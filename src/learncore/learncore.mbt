///|
/// # learncore 模型/学习类算法算子 / Model & Learning Algorithm Operators
///
/// 把 ML/DL 的算法建模为一等算子，与数据算子同处一套契约。架构 §4.3.5。
/// S1.2 基礎：传统 ML（回归/分类/聚类/降维）+ 评估指标算子。
///
/// # Model & learning algorithm9 operators
///
/// ML/DL algorithms as first-class operators. See architecture §4.3.5.
/// S1.2: traditional ML (regression/classify/cluster/feature) + metrics.

///|
/// 算法族 / Model space.
pub(all) enum ModelSpace {
  ML
  DL
  SSL
  Eval
  Adapt
  Optim
} derive(Debug, Eq)

///|
pub extend ModelSpace with Eq::{equal, not_equal}

///|
pub extend ModelSpace with Debug::{to_repr}

///|
/// 算法族名称 / Model space name.
pub fn model_space_name(ms : ModelSpace) -> String {
  match ms {
    ML => "ml"
    DL => "dl"
    SSL => "ssl"
    Eval => "eval"
    Adapt => "adapt"
    Optim => "optim"
  }
}

///|
/// 超参空间占位 / Hyperparameter space (placeholder).
pub struct Hyperparams {
  name : String
  values : Array[String]
} derive(Debug, Eq)

///|
pub extend Hyperparams with Eq::{equal, not_equal}

///|
pub extend Hyperparams with Debug::{to_repr}

///|
/// 构造超参空间 / Build hyperparameter space.
pub fn make_hyperparams(name : String, values : Array[String]) -> Hyperparams {
  { name, values, }
}

///|
pub fn learncore_id() -> String {
  "learncore"
}
