///|
/// # dosi/verifier 索引校验器 / Index Verifier
///
/// 校验索引依赖图 + 检测循环依赖 + 依赖存在性检查。架构 §4.7.3。
/// S1.7 基礎：verify_index + check_dependencies + detect_cycles。
///
/// # Index verifier
///
/// Verify index dependency graph + cycle detection. See architecture §4.7.3.

/// 校验结果 / Verification result.
pub struct VerifyResult {
  valid : Bool
  issues : Array[String]
} derive(Debug, Eq)

pub extend VerifyResult with Eq::{equal, not_equal}
pub extend VerifyResult with Debug::{to_repr}

/// 校验索引 / Verify DOSI index.
///
/// 检查：1) 依赖路径在索引中存在 2) 无循环依赖。
pub fn verify_index(index : @dosi.DOSIIndex) -> VerifyResult {
  let issues = []
  let entries = index.entries()
  let paths = []
  for i = 0; i < entries.length(); i = i + 1 {
    paths.push(entries[i].symbolic.path)
  }
  // 检查依赖存在性
  for i = 0; i < entries.length(); i = i + 1 {
    let deps = entries[i].symbolic.dependencies
    for j = 0; j < deps.length(); j = j + 1 {
      let mut found = false
      for k = 0; k < paths.length(); k = k + 1 {
        if paths[k] == deps[j] {
          found = true
        }
      }
      if !found {
        issues.push("missing dependency: " + deps[j] + " (required by " + entries[i].symbolic.path + ")")
      }
    }
  }
  // 检查循环依赖（简化：自依赖）
  for i = 0; i < entries.length(); i = i + 1 {
    let path = entries[i].symbolic.path
    let deps = entries[i].symbolic.dependencies
    for j = 0; j < deps.length(); j = j + 1 {
      if deps[j] == path {
        issues.push("self-dependency: " + path)
      }
    }
  }
  { valid: issues.length() == 0, issues }
}

/// 检查依赖是否存在 / Check if all dependencies exist.
pub fn check_dependencies(index : @dosi.DOSIIndex) -> Bool {
  let result = verify_index(index)
  result.valid
}

/// 检测循环依赖 / Detect circular dependencies (self-dependency).
///
/// 返回有自依赖的路径列表。
pub fn detect_cycles(index : @dosi.DOSIIndex) -> Array[String] {
  let cycles = []
  let entries = index.entries()
  for i = 0; i < entries.length(); i = i + 1 {
    let path = entries[i].symbolic.path
    let deps = entries[i].symbolic.dependencies
    for j = 0; j < deps.length(); j = j + 1 {
      if deps[j] == path {
        cycles.push(path)
      }
    }
  }
  cycles
}

/// 空校验结果 / Empty verify result (valid).
pub fn valid_result() -> VerifyResult {
  { valid: true, issues: [] }
}

pub fn verifier_id() -> String {
  "dosi/verifier"
}