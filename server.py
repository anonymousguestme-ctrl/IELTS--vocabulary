"""Local static server and DeepSeek lookup proxy.

Run with: DEEPSEEK_API_KEY=your_key python3 server.py
Then open http://127.0.0.1:8765/.
"""
import json
import os
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from urllib.request import Request, urlopen


class Handler(SimpleHTTPRequestHandler):
    def do_POST(self):
        if self.path != "/api/lookup":
            self.send_error(404)
            return
        key = os.environ.get("DEEPSEEK_API_KEY")
        if not key:
            try:
                length = int(self.headers.get("Content-Length", "0"))
                body = json.loads(self.rfile.read(length))
            except (ValueError, json.JSONDecodeError):
                body = {}
            key = str(body.get("key", "")).strip()
        else:
            body = None
        if not key:
            self.send_json(503, {"error": "DeepSeek API Key is not configured"})
            return
        try:
            if body is None:
                length = int(self.headers.get("Content-Length", "0"))
                body = json.loads(self.rfile.read(length))
            term = str(body.get("word", "")).strip()
            if not term:
                self.send_json(400, {"error": "word is required"})
                return
            prompt = (
                "Return JSON only with keys pos, meaning, phrase, sentence. "
                "You are an IELTS vocabulary tutor. For the English word or phrase "
                f"{term!r}, give concise Chinese meaning, standard part of speech, "
                "up to three useful collocations as an array, and one natural English "
                "example sentence. Use an empty array/string when unavailable."
            )
            payload = json.dumps({
                "model": "deepseek-chat",
                "messages": [{"role": "system", "content": "You answer in valid JSON."}, {"role": "user", "content": prompt}],
                "response_format": {"type": "json_object"},
                "temperature": 0.2,
                "max_tokens": 500,
            }).encode()
            req = Request("https://api.deepseek.com/chat/completions", data=payload, headers={"Authorization": f"Bearer {key}", "Content-Type": "application/json"}, method="POST")
            with urlopen(req, timeout=20) as response:
                result = json.loads(response.read())
            content = result["choices"][0]["message"]["content"]
            self.send_json(200, json.loads(content))
        except Exception as exc:
            self.send_json(502, {"error": str(exc)})

    def send_json(self, status, payload):
        data = json.dumps(payload, ensure_ascii=False).encode()
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


if __name__ == "__main__":
    print("Word Bench running at http://127.0.0.1:8765/")
    ThreadingHTTPServer(("127.0.0.1", 8765), Handler).serve_forever()
