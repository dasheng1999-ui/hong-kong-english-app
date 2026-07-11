# BoBo English 内容表格与后台改造说明

这份说明用于下次继续开发时随 Excel 一起交给 Codex。目标是：用户只维护 `quick_words`，其余正式数据表和 App 题库由 Codex 批量生成。

## 1. 推荐工作流

用户优先填写新版 Excel：

`content/bobo_content_quick_template.xlsx`

最重要的 Sheet 是：

`quick_words`

用户只需要先填：

| 列名 | 含义 |
|---|---|
| `unit_key` | 单元编号，例如 `1A_U1` |
| `form` | 年级：`F1` / `F2` / `F3` |
| `book` | 册别，例如 `1A` |
| `unit_num` | 第几单元，例如 `1` |
| `theme_en` | 英文主题 |
| `theme_zh` | 中文主题 |
| `group_no` | 第几组 |
| `word_order` | 组内顺序 |
| `en` | 英文单词或词组 |
| `pos` | 词性 |
| `zh` | 中文意思 |
| `source_sentence` | 可选，原句或粗略例句，Codex 负责改写为原创 |
| `focus` | 可选，想重点考什么，例如 `word_form; preposition` |
| `notes` | 可选，教师备注、来源、版权要求 |
| `enabled` | `TRUE` / `FALSE` |

用户填好一个单元后，把 Excel 和本说明一起交给 Codex。

## 2. Codex 需要自动生成的内容

从 `quick_words` 生成或补齐：

| 目标表 | 生成规则 |
|---|---|
| `units` | 按 `unit_key` 去重生成单元 |
| `words` | 每个 quick_words 行生成一条正式单词数据 |
| `phrases` | 根据词组、搭配、主题生成短语数据 |
| `passages` | 每个 `unit_key + group_no` 生成一篇原创短文 |
| `word_tests` | 每个词生成 2-4 道考点题 |

Codex 可以自动补：

- `category`
- `source_note`
- `app_sentence`
- `exam_tip`
- `error_tip`
- `collocations`
- `example_1`
- `example_2`
- `option_a` / `option_b` / `option_c` / `option_d`
- `answer`
- `explanation`
- `weakness_tag`
- `difficulty`

## 3. 版权安全规则

如果 `source_sentence` 来自教材或用户截图：

1. 不直接复制原句进 App。
2. 改写成新的原创例句。
3. 保留目标单词和考点。
4. 场景可以相似，但表达、结构、人物、细节应改变。
5. `source_note` 建议填 `Original replacement sentence` 或 `AI-rewritten from teacher brief`。

## 4. category 简化分类

`words.category` 只使用 5 类：

| 类别 | 用途 |
|---|---|
| `核心詞彙` | 单元必须掌握的主词 |
| `高頻基礎詞` | 基础常用词 |
| `考試重點詞` | 阅读、填空、词形转换常考 |
| `短語搭配` | 固定搭配、词组、phrasal verb |
| `拓展詞彙` | 额外补充、进阶词 |

## 5. word_tests 考点类型

`word_tests.test_type` 可用：

| test_type | 含义 |
|---|---|
| `word_form` | 词性变化 |
| `plural` | 名词单复数 |
| `tense` | 动词时态 |
| `preposition` | 介词搭配 |
| `collocation` | 固定搭配 |
| `countability` | 可数/不可数 |
| `ed_ing` | -ed / -ing 形容词 |
| `gerund_infinitive` | 动名词/不定式 |
| `subject_verb_agreement` | 主谓一致 |
| `article` | 冠词 |
| `confusing_words` | 易混词 |
| `context_meaning` | 语境判断 |
| `spelling` | 拼写 |
| `writing_upgrade` | 写作替换 |

`weakness_tag` 对应学生薄弱点：

| weakness_tag | 含义 |
|---|---|
| `詞性變化` | noun / verb / adj / adv 转换弱 |
| `名詞單複數` | 单复数变化弱 |
| `動詞時態` | 时态弱 |
| `介詞搭配` | 介词搭配弱 |
| `固定搭配` | collocation 弱 |
| `可數不可數` | countable / uncountable 弱 |
| `ed/ing形容詞` | excited / exciting 类型弱 |
| `動名詞/不定式` | doing / to do 弱 |
| `主謂一致` | subject-verb agreement 弱 |
| `冠詞` | a / an / the 弱 |
| `易混詞` | 近义词或形近词混淆 |
| `語境判斷` | 根据上下文判断词义弱 |
| `拼寫` | spelling 弱 |
| `寫作替換` | 不会使用更好表达 |

## 6. 一组 15-20 个词时的后台改造要求

当前旧 App 逻辑接近“每组 9 个词”的设计。如果改成每组 15-20 个词，不建议让学生一轮做完全部词，否则太长。

后台需要改成：

1. `group_no` 仍然是一组，但一组可以有 15-20 个词。
2. 每次练习从该组抽取一部分词，例如 8-10 个。
3. 每个词仍保留三层进度：识义层、应用层、阅读层。
4. 单次 session 控制在 10-15 道题左右。
5. App 首页显示组进度时，用全组掌握度计算，而不是固定 9 个词。
6. 解锁下一组时，不要求每个词都一次完成，而是按掌握比例或星星数判断。

建议参数：

| 参数 | 建议值 |
|---|---|
| 每组词数 | 15-20 |
| 每次练习目标词 | 8-10 |
| 每次题目数 | 10-15 |
| 阅读短文目标词 | 5-8 |
| 通过一组要求 | 全组 70%-80% 词达到当前层要求 |
| 复习优先级 | 错题 > 久未复习 > 未掌握 > 新词 |

## 7. 后台题目生成策略

第二轮：

1. 优先使用 `word_tests`。
2. 没有 `word_tests` 时，用旧逻辑自动生成拼写、听音、搭配题。
3. 做错时记录 `weakness_tag`。

第三轮：

1. 优先使用 `passages` 表中的原创短文。
2. 每篇短文使用 5-8 个本组词。
3. 题型可以是 `fill_blank`、`choose_word`、`word_form`、`mixed`。
4. 如果没有短文，才使用旧逻辑兜底，不能再简单拼接旧例句作为正式内容。

## 8. Excel 导入检查

导入前需要检查：

- `unit_key` 是否能在 `units` 中找到。
- 每个 `unit_key + group_no` 是否有词。
- `word_order` 是否重复。
- `en` 是否重复或大小写冲突。
- `answer` 是否出现在 `option_a-d` 中。
- `enabled` 是否为 `TRUE` / `FALSE`。
- `passage_text` 是否为空。
- `target_words` 是否都存在于该组词库。
- 是否有疑似直接复制教材的长句。

## 9. 下次给 Codex 的指令

下次可以这样说：

“这是我填好的 BoBo English 词库 Excel，请按 `bobo_content_backend_rules.md` 的规则，先从 `quick_words` 生成正式的 `units / words / phrases / passages / word_tests`，再检查数据质量，并告诉我哪些地方需要补充或修正。”

