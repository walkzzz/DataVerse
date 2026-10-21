///|
/// # opcore/plugin 插件系统 / Plugin System
///
/// 动态算子注册扩展：插件元数据 + 依赖管理 + 状态机。
/// 架构 §4.3 算子注册表扩展。S3.3 填充。
///
/// # Plugin system
///
/// Dynamic operator registration: metadata + dependencies + status machine.

///|
/// 插件状态 / Plugin status.
pub(all) enum PluginStatus {
  Loaded // 已加载
  Active // 已激活
  Disabled // 已禁用
  Error // 错误
} derive(Debug, Eq)

///|
pub extend PluginStatus with Eq::{equal, not_equal}

///|
pub extend PluginStatus with Debug::{to_repr}

///|
/// 插件状态名称 / Plugin status name.
pub fn plugin_status_name(s : PluginStatus) -> String {
  match s {
    Loaded => "loaded"
    Active => "active"
    Disabled => "disabled"
    Error => "error"
  }
}

///|
/// 插件元数据 / Plugin metadata.
pub struct PluginMeta {
  name : String
  version : String
  author : String
  entry_point : String
  description : String
} derive(Debug, Eq)

///|
pub extend PluginMeta with Eq::{equal, not_equal}

///|
pub extend PluginMeta with Debug::{to_repr}

///|
/// 构造插件元数据 / Build plugin metadata.
pub fn make_plugin_meta(
  name : String,
  version : String,
  author : String,
  entry_point : String,
  description : String,
) -> PluginMeta {
  { name, version, author, entry_point, description, }
}

///|
/// 插件依赖 / Plugin dependency.
pub struct PluginDependency {
  name : String
  min_version : String
} derive(Debug, Eq)

///|
pub extend PluginDependency with Eq::{equal, not_equal}

///|
pub extend PluginDependency with Debug::{to_repr}

///|
/// 构造插件依赖 / Build plugin dependency.
pub fn make_plugin_dependency(
  name : String,
  min_version : String,
) -> PluginDependency {
  { name, min_version, }
}

///|
/// 插件条目 / Plugin entry (metadata + status + dependencies).
pub struct PluginEntry {
  meta : PluginMeta
  status : PluginStatus
  dependencies : Array[PluginDependency]
} derive(Debug, Eq)

///|
pub extend PluginEntry with Eq::{equal, not_equal}

///|
pub extend PluginEntry with Debug::{to_repr}

///|
/// 构造插件条目 / Build plugin entry.
pub fn make_plugin_entry(
  meta : PluginMeta,
  status : PluginStatus,
  dependencies : Array[PluginDependency],
) -> PluginEntry {
  { meta, status, dependencies, }
}

///|
/// 插件注册表 / Plugin registry.
pub struct PluginRegistry {
  plugins : Array[PluginEntry]
} derive(Debug, Eq)

///|
pub extend PluginRegistry with Eq::{equal, not_equal}

///|
pub extend PluginRegistry with Debug::{to_repr}

///|
/// 空插件注册表 / Empty plugin registry.
pub fn empty_plugin_registry() -> PluginRegistry {
  { plugins: [], }
}

///|
/// 注册插件 / Register plugin.
///
/// 退化安全：同名插件不重复注册。
pub fn register_plugin(
  registry : PluginRegistry,
  entry : PluginEntry,
) -> PluginRegistry {
  let mut already = false
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].meta.name == entry.meta.name {
      already = true
    }
  }
  if already {
    registry
  } else {
    let new_plugins : Array[PluginEntry] = []
    for i in 0..<registry.plugins.length() {
      new_plugins.push(registry.plugins[i])
    }
    new_plugins.push(entry)
    { plugins: new_plugins, }
  }
}

///|
/// 注销插件 / Unregister plugin by name.
pub fn unregister_plugin(
  registry : PluginRegistry,
  name : String,
) -> PluginRegistry {
  let new_plugins : Array[PluginEntry] = []
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].meta.name != name {
      new_plugins.push(registry.plugins[i])
    }
  }
  { plugins: new_plugins, }
}

///|
/// 列出所有插件名 / List all plugin names.
pub fn list_plugins(registry : PluginRegistry) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<registry.plugins.length() {
    result.push(registry.plugins[i].meta.name)
  }
  result
}

///|
/// 查询插件状态 / Get plugin status by name.
///
/// 退化安全：未找到返回 Error。
pub fn get_plugin_status(
  registry : PluginRegistry,
  name : String,
) -> PluginStatus {
  let mut result = Error
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].meta.name == name {
      result = registry.plugins[i].status
    }
  }
  result
}

///|
/// 启用插件 / Enable plugin (set status to Active).
pub fn enable_plugin(
  registry : PluginRegistry,
  name : String,
) -> PluginRegistry {
  let new_plugins : Array[PluginEntry] = []
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].meta.name == name {
      new_plugins.push({
        meta: registry.plugins[i].meta,
        status: Active,
        dependencies: registry.plugins[i].dependencies,
      })
    } else {
      new_plugins.push(registry.plugins[i])
    }
  }
  { plugins: new_plugins, }
}

///|
/// 禁用插件 / Disable plugin (set status to Disabled).
pub fn disable_plugin(
  registry : PluginRegistry,
  name : String,
) -> PluginRegistry {
  let new_plugins : Array[PluginEntry] = []
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].meta.name == name {
      new_plugins.push({
        meta: registry.plugins[i].meta,
        status: Disabled,
        dependencies: registry.plugins[i].dependencies,
      })
    } else {
      new_plugins.push(registry.plugins[i])
    }
  }
  { plugins: new_plugins, }
}

///|
/// 插件计数 / Plugin count.
pub fn plugin_count(registry : PluginRegistry) -> Int32 {
  registry.plugins.length()
}

///|
/// 按状态过滤插件 / Filter plugins by status.
pub fn plugins_by_status(
  registry : PluginRegistry,
  status : PluginStatus,
) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].status == status {
      result.push(registry.plugins[i].meta.name)
    }
  }
  result
}

///|
/// 检查依赖是否满足 / Check if dependency is satisfied.
///
/// 简化：检查依赖名是否在注册表中（版本检查略）。
pub fn check_dependency(
  registry : PluginRegistry,
  dep : PluginDependency,
) -> Bool {
  let mut found = false
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].meta.name == dep.name {
      found = true
    }
  }
  found
}

///|
/// 检查插件所有依赖 / Check all dependencies of a plugin.
pub fn check_all_dependencies(registry : PluginRegistry, name : String) -> Bool {
  let mut deps : Array[PluginDependency] = []
  for i in 0..<registry.plugins.length() {
    if registry.plugins[i].meta.name == name {
      deps = registry.plugins[i].dependencies
    }
  }
  if deps.length() == 0 {
    true
  } else {
    let mut all_ok = true
    for i in 0..<deps.length() {
      if !check_dependency(registry, deps[i]) {
        all_ok = false
      }
    }
    all_ok
  }
}

///|
/// 插件注册表 URI / Plugin registry URI.
pub fn plugin_registry_uri(registry : PluginRegistry) -> String {
  "plugin://registry?count=" + registry.plugins.length().to_string()
}

///|
pub fn plugin_id() -> String {
  "opcore/plugin"
}
