///|
/// # agent_kit/prompt Prompt 工程 / Prompt Engineering
///
/// Prompt 模板、变量替换、链式构建、few-shot。
/// S11.3 新建。
///
/// # Prompt engineering operators

///|
/// Prompt 模板 / Prompt template.
pub struct PromptTemplate {
  name : String
  template : String
  variables : Array[String]
}

///|
/// Few-shot 示例 / Few-shot example.
pub struct FewShotExample {
  input : String
  output : String
}

///|
/// 构造 Prompt 模板 / Create prompt template.
pub fn make_template(
  name : String,
  template : String,
  variables : Array[String],
) -> PromptTemplate {
  { name, template, variables, }
}

///|
/// 构造 few-shot 示例 / Create few-shot example.
pub fn make_few_shot(input : String, output : String) -> FewShotExample {
  { input, output, }
}

///===
/// 变量替换 / Variable substitution

///|
/// 替换变量 / Replace variable in template.
pub fn replace_variable(
  template : String,
  var_name : String,
  value : String,
) -> String {
  let placeholder = "{" + var_name + "}"
  template.replace(old=placeholder, new=value)
}

///|
/// 替换所有变量 / Replace all variables.
pub fn replace_all_variables(
  template : String,
  vars : Array[(String, String)],
) -> String {
  let mut result = template
  for i in 0..<vars.length() {
    result = replace_variable(result, vars[i].0, vars[i].1)
  }
  result
}

///|
/// 渲染模板 / Render template with variables.
pub fn render_template(
  tmpl : PromptTemplate,
  vars : Array[(String, String)],
) -> String {
  replace_all_variables(tmpl.template, vars)
}

///===
/// Prompt 构建 / Prompt building

///|
/// 构建 system prompt / Build system prompt.
pub fn build_system_prompt(role : String, instructions : String) -> String {
  "You are a " + role + ". " + instructions
}

///|
/// 构建 user prompt / Build user prompt.
pub fn build_user_prompt(question : String, context : String) -> String {
  if context.length() > 0 {
    "Context: " + context + "\n\nQuestion: " + question
  } else {
    question
  }
}

///===
/// Few-shot / Few-shot prompting

///|
/// 构建 few-shot prompt / Build few-shot prompt.
pub fn build_few_shot_prompt(
  instruction : String,
  examples : Array[FewShotExample],
  query : String,
) -> String {
  let mut result = instruction + "\n\n"
  for i in 0..<examples.length() {
    result = result + "Input: " + examples[i].input + "\n"
    result = result + "Output: " + examples[i].output + "\n\n"
  }
  result = result + "Input: " + query + "\n"
  result = result + "Output: "
  result
}

///===
/// 链式 Prompt / Prompt chaining

///|
/// Prompt 链 / Prompt chain.
pub struct PromptChain {
  steps : Array[PromptTemplate]
  separator : String
}

///|
/// 构造 Prompt 链 / Create prompt chain.
pub fn make_chain(
  steps : Array[PromptTemplate],
  separator : String,
) -> PromptChain {
  { steps, separator, }
}

///|
/// 渲染链 / Render chain.
pub fn render_chain(
  chain : PromptChain,
  vars : Array[(String, String)],
) -> String {
  let mut result = ""
  for i in 0..<chain.steps.length() {
    if i > 0 {
      result = result + chain.separator
    }
    result = result + render_template(chain.steps[i], vars)
  }
  result
}

///|
/// 追加步骤 / Append step to chain.
pub fn append_step(chain : PromptChain, step : PromptTemplate) -> PromptChain {
  let new_steps = chain.steps.copy()
  new_steps.push(step)
  { ..chain, steps: new_steps, }
}

///===
/// Prompt 分析 / Prompt analysis

///|
/// 统计变量数 / Count variables in template.
pub fn count_variables(template : String) -> Int32 {
  let mut count = 0
  let mut in_var = false
  for i in 0..<template.length() {
    let code = template[i].to_int()
    if code == 123 {
      in_var = true
    } else if code == 125 && in_var {
      count = count + 1
      in_var = false
    }
  }
  count
}

///|
/// 提取变量名 / Extract variable names from template.
pub fn extract_variables(template : String) -> Array[String] {
  let vars : Array[String] = []
  let mut current = ""
  let mut in_var = false
  for i in 0..<template.length() {
    let code = template[i].to_int()
    if code == 123 {
      in_var = true
      current = ""
    } else if code == 125 && in_var {
      if current.length() > 0 {
        vars.push(current)
      }
      in_var = false
      current = ""
    } else if in_var {
      current = current + Int32::unsafe_to_char(code).to_string()
    }
  }
  vars
}

///|
///===
/// ID
pub fn prompt_id() -> String {
  "agent_kit/prompt"
}
