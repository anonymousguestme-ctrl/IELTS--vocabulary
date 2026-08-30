# 项目交接文档｜本地的雅思单词本

## 项目身份

- 项目名称：`IELTS Vocabulary Bench｜本地的雅思单词本`
- GitHub：<https://github.com/anonymousguestme-ctrl/IELTS--vocabulary>
- 本地路径：项目所在的 `IELTS- vocabulary` 目录
- 当前分支：`main`
- 当前最新提交：`0ffc579 feat: add search clear button`

这是一个纯 HTML、CSS 和原生 JavaScript 的本地雅思词汇工具。直接打开 `index.html` 即可使用；DeepSeek 查询需要额外启动本地 `server.py`。

## 已完成的功能

### 词汇记录

每条记录可以保存英文内容、词性、中文释义、可选短语、可选例句、关联词汇、分类和掌握状态。新增内容、勾选状态和查询缓存保存在当前浏览器的 `localStorage` 中。

### 查询和录入逻辑

查询顺序为：浏览器缓存、本地 Excel 词库、两个 GitHub 词库、公开英文词典。公开词典请求最多等待 4 秒；失败后，如果页面已保存 DeepSeek Key，会自动调用 DeepSeek。

录入区有三种模式：单词显示词性和释义；短语 / 固定搭配不显示词性，可填写释义和例句；句子只保存句子，不查询词性、释义和常用短语。三种模式都支持 Enter 提交。

### 关联词汇组

每条记录有一个可选的 `related` 字段，使用换行分隔多个关联词。系统会自动建议 `atmosphere`、`hydrosphere`、`lithosphere`、`biosphere` 等词组。保存单词时，尚未存在的关联词会自动创建为独立词汇卡，并优先从离线词库填入词性和释义；如果关联词已经存在于词库，会自动把关系补到双方。

### 分类

录入区提供自然地理、植物研究、动物保护、太空探索、环境气候、电影影视、教育学习、科技互联网、社会公共、健康生活、旅行交通、工作经济、文化艺术、科学医学和未分类。分类优先采用雅思真经章节数据；输入单词离开输入框时会按关键词自动建议分类，用户可以在下拉框中修改；卡片会显示分类标签。

### 近义词程度比较

`app.js` 内置了灾难词组比较：`disastrous`、`catastrophic`、`calamity`。卡片会显示词性、中文语气和典型用法，提醒用户 `calamity` 是名词，不能与两个形容词直接互换。

### 复习与打印

- 按“全部 / 不会 / 会了”筛选。
- 复选框标记已掌握词汇。
- “隐藏释义”按钮一次隐藏全部词性和释义。
- 空的短语和例句不会显示。
- 打印时隐藏录入区、操作按钮和已掌握条目。
- 点击卡片主体可回填到左侧表单进行编辑。
- 搜索框右侧的 `×` 可以清空搜索内容并立即恢复当前筛选列表。

### DeepSeek

左侧默认只显示“DeepSeek 设置”按钮。展开后可以保存或清除 API Key。Key 保存在浏览器本地，不写入 GitHub；服务端也支持环境变量 `DEEPSEEK_API_KEY`，环境变量优先。

公开词典未找到词条时，已保存 Key 会触发自动 DeepSeek 查询，自动填入词性、中文释义、解释、短语和例句。页面上的手动按钮仍可用于重试。

## 内置词库

| 文件 | 来源 | 约包含词条 |
| --- | --- | ---: |
| `ielts-dictionary.js` | 本地《语料库练习模板(剑19)-2025.7.6.xlsx》 | 5,222 |
| `repo-ielts-dictionary.js` | `fanhongtao/IELTS` 的 `IELTS Word List.txt` | 3,589 |
| `hf-ielts-dictionary.js` | `hefengxian/my-ielts` 词汇模块 | 3,697 |
| `lynn-ielts-dictionary.js` | `LynnShaw/vocabulary_for_ielts` 的 `word_list.csv` | 3,589 |

## 文件说明

```text
index.html                  页面结构
styles.css                  页面、响应式和打印样式
app.js                      交互、查询、本地保存、筛选和关联组
server.py                   本地静态服务器和 DeepSeek 代理
启动雅思词汇本.command       macOS 双击启动脚本
ielts-dictionary.js         Excel 提取的词库
repo-ielts-dictionary.js    fanhongtao/IELTS 词库
hf-ielts-dictionary.js      hefengxian/my-ielts 词库
README.md                   项目使用说明
HANDOFF.md                  中文工程交接文档
notes.md                    工作笔记
task_plan.md                原始计划
```

## 运行方式

只使用本地词库：

```bash
open "项目目录/IELTS- vocabulary/index.html"
```

使用 DeepSeek 自动查询：

```bash
cd "项目目录/IELTS- vocabulary"
python3 server.py
```

然后打开 <http://127.0.0.1:8765/>，点击“DeepSeek 设置”保存 Key。也可以设置 `DEEPSEEK_API_KEY` 环境变量。

在 macOS 中也可以直接双击项目目录里的 `启动雅思词汇本.command`。脚本会自动打开浏览器和本地服务；关闭随后打开的 Terminal 窗口即可停止服务。

## 已完成的验证

- `node --check app.js` 通过。
- 三个词库 JavaScript 文件均通过语法检查。
- `python3 -m py_compile server.py` 通过。
- 本地服务器可以正常返回页面。
- 未配置 Key 时接口返回明确错误；无效 Key 时返回认证错误。
- 关联组渲染和双向同步代码已写入 `app.js`。
- GitHub `main` 已与本地最新提交同步。

## 当前限制

1. 分类自动建议基于关键词，属于启发式结果；请在下拉框中人工确认。
2. 词性推断基于词尾规则，属于启发式结果；显示“待确认”时应人工检查。
3. 词库来源中的例句和主题字段没有全部自动展示。
4. 学习记录只保存在当前浏览器，清除站点数据或更换浏览器后可能不可见。
5. 公开词典和 DeepSeek 都需要网络；DeepSeek 需要用户自己的 API Key。
6. API Key 保存在浏览器时不适合共享电脑，使用后应点击“清除”。

## 后续建议

### P1：导入导出

增加 JSON 导入和导出，便于备份浏览器本地学习记录并迁移到其他设备。

### P2：丰富词库字段

保留词库来源中的主题、例句和补充字段，并在卡片中作为可选详情显示。

## 关键提交记录

- `febf668` 初始离线词汇本
- `ee4ce0a` 全局隐藏释义和卡片对齐
- `36fbf34` 接入 hefengxian/my-ielts 词库
- `a1e62dc` 修正导入词性的通用映射
- `a9ae1be` 增加词性选择器
- `a68b204` 增加卡片编辑
- `c4a7f45` 支持页面保存 DeepSeek Key
- `fd9953e` 增加关联词汇组和隐藏设置
- `8859a48` 增加关联词双向同步
- `3bd1cbc` 公开词典失败后自动调用 DeepSeek

## 交接清单

- [x] 桌面目录存在：`IELTS- vocabulary`
- [x] 远程仓库为 `anonymousguestme-ctrl/IELTS--vocabulary`
- [x] 当前实现已推送到 `origin/main`
- [x] README 不包含图片嵌入，查询逻辑包含文本流程图
- [x] 三个离线词库已由页面加载
- [x] 中文交接文档已更新
