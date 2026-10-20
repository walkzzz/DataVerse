///===
/// extcore/opt_meta_bayes

pub(all) struct OptmetabayesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_bayes_make_point(x : Double, y : Double) -> OptmetabayesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_bayes_make_point3(x : Double, y : Double, z : Double) -> OptmetabayesPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetabayesPoint::x(self : OptmetabayesPoint) -> Double { self.x }

pub fn OptmetabayesPoint::y(self : OptmetabayesPoint) -> Double { self.y }

pub fn OptmetabayesPoint::z(self : OptmetabayesPoint) -> Double { self.z }

pub fn OptmetabayesPoint::label(self : OptmetabayesPoint) -> Int { self.label }

pub fn OptmetabayesPoint::dist(self : OptmetabayesPoint, other : OptmetabayesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetabayesPoint::add(self : OptmetabayesPoint, other : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetabayesPoint::sub(self : OptmetabayesPoint, other : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetabayesPoint::scale(self : OptmetabayesPoint, s : Double) -> OptmetabayesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetabayesPoint::dot(self : OptmetabayesPoint, other : OptmetabayesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetabayesPoint::cross(self : OptmetabayesPoint, other : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetabayesPoint::norm(self : OptmetabayesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetabayesPoint::normalize(self : OptmetabayesPoint) -> OptmetabayesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetabayesPoint::negate(self : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetabayesPoint::mid(self : OptmetabayesPoint, other : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetabayesPoint::lerp(self : OptmetabayesPoint, other : OptmetabayesPoint, t : Double) -> OptmetabayesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetabayesPoint::to_string(self : OptmetabayesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetabayesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_bayes_make_series(vals : Array[Double], name : String) -> OptmetabayesSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetabayesSeries::len(self : OptmetabayesSeries) -> Int { self.vals.length() }

pub fn OptmetabayesSeries::sum(self : OptmetabayesSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetabayesSeries::mean(self : OptmetabayesSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetabayesSeries::min(self : OptmetabayesSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetabayesSeries::max(self : OptmetabayesSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetabayesSeries::range(self : OptmetabayesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetabayesSeries::variance(self : OptmetabayesSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetabayesSeries::std(self : OptmetabayesSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetabayesSeries::median(self : OptmetabayesSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetabayesSeries::scale(self : OptmetabayesSeries, f : Double) -> OptmetabayesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetabayesSeries::add(self : OptmetabayesSeries, other : OptmetabayesSeries) -> OptmetabayesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetabayesSeries::sub(self : OptmetabayesSeries, other : OptmetabayesSeries) -> OptmetabayesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetabayesSeries::normalize(self : OptmetabayesSeries) -> OptmetabayesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetabayesSeries::cumsum(self : OptmetabayesSeries) -> OptmetabayesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetabayesSeries::to_string(self : OptmetabayesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetabayesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_bayes_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetabayesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_bayes_matrix_identity(n : Int) -> OptmetabayesMatrix {
  let m = opt_meta_bayes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetabayesMatrix::get(self : OptmetabayesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetabayesMatrix::transpose(self : OptmetabayesMatrix) -> OptmetabayesMatrix {
  let result = opt_meta_bayes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetabayesMatrix::add(self : OptmetabayesMatrix, other : OptmetabayesMatrix) -> OptmetabayesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_bayes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetabayesMatrix::scale(self : OptmetabayesMatrix, s : Double) -> OptmetabayesMatrix {
  let result = opt_meta_bayes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetabayesMatrix::multiply(self : OptmetabayesMatrix, other : OptmetabayesMatrix) -> OptmetabayesMatrix {
  if self.cols != other.rows { return opt_meta_bayes_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_bayes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetabayesMatrix::trace(self : OptmetabayesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetabayesMatrix::det(self : OptmetabayesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetabayesMatrix::norm(self : OptmetabayesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetabayesMatrix::to_string(self : OptmetabayesMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptmetabayesVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_bayes_make_vector(comps : Array[Double]) -> OptmetabayesVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_bayes_vector_zero(dim : Int) -> OptmetabayesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetabayesVector::add(self : OptmetabayesVector, other : OptmetabayesVector) -> OptmetabayesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetabayesVector::sub(self : OptmetabayesVector, other : OptmetabayesVector) -> OptmetabayesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetabayesVector::scale(self : OptmetabayesVector, s : Double) -> OptmetabayesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetabayesVector::dot(self : OptmetabayesVector, other : OptmetabayesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetabayesVector::norm(self : OptmetabayesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetabayesVector::normalize(self : OptmetabayesVector) -> OptmetabayesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetabayesVector::dist(self : OptmetabayesVector, other : OptmetabayesVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetabayesVector::to_string(self : OptmetabayesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_bayes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_bayes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_bayes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_bayes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_bayes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_bayes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_bayes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_bayes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_bayes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_bayes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_bayes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_bayes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_bayes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_bayes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_bayes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_bayes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_bayes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_bayes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_bayes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_bayes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_bayes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_bayes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_bayes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_bayes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_bayes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_bayes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_bayes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_bayes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_bayes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetabayesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_frame_make(size : Int) -> OptmetabayesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesFrame::len(self : OptmetabayesFrame) -> Int { self.size }

pub fn OptmetabayesFrame::get(self : OptmetabayesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesFrame::set(self : OptmetabayesFrame, i : Int, v : Double) -> OptmetabayesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesFrame::sum(self : OptmetabayesFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesFrame::mean(self : OptmetabayesFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesFrame::scale(self : OptmetabayesFrame, f : Double) -> OptmetabayesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesFrame::add(self : OptmetabayesFrame, other : OptmetabayesFrame) -> OptmetabayesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesFrame::copy(self : OptmetabayesFrame) -> OptmetabayesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesFrame::fill(self : OptmetabayesFrame, v : Double) -> OptmetabayesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesFrame::min(self : OptmetabayesFrame) -> Double { @_common.min(self.data) }

pub fn OptmetabayesFrame::max(self : OptmetabayesFrame) -> Double { @_common.max(self.data) }

pub fn OptmetabayesFrame::to_string(self : OptmetabayesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_table_make(size : Int) -> OptmetabayesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesTable::len(self : OptmetabayesTable) -> Int { self.size }

pub fn OptmetabayesTable::get(self : OptmetabayesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesTable::set(self : OptmetabayesTable, i : Int, v : Double) -> OptmetabayesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesTable::sum(self : OptmetabayesTable) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesTable::mean(self : OptmetabayesTable) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesTable::scale(self : OptmetabayesTable, f : Double) -> OptmetabayesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesTable::add(self : OptmetabayesTable, other : OptmetabayesTable) -> OptmetabayesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesTable::copy(self : OptmetabayesTable) -> OptmetabayesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesTable::fill(self : OptmetabayesTable, v : Double) -> OptmetabayesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesTable::min(self : OptmetabayesTable) -> Double { @_common.min(self.data) }

pub fn OptmetabayesTable::max(self : OptmetabayesTable) -> Double { @_common.max(self.data) }

pub fn OptmetabayesTable::to_string(self : OptmetabayesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_graphn_make(size : Int) -> OptmetabayesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesGraphN::len(self : OptmetabayesGraphN) -> Int { self.size }

pub fn OptmetabayesGraphN::get(self : OptmetabayesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesGraphN::set(self : OptmetabayesGraphN, i : Int, v : Double) -> OptmetabayesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesGraphN::sum(self : OptmetabayesGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesGraphN::mean(self : OptmetabayesGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesGraphN::scale(self : OptmetabayesGraphN, f : Double) -> OptmetabayesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesGraphN::add(self : OptmetabayesGraphN, other : OptmetabayesGraphN) -> OptmetabayesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesGraphN::copy(self : OptmetabayesGraphN) -> OptmetabayesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesGraphN::fill(self : OptmetabayesGraphN, v : Double) -> OptmetabayesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesGraphN::min(self : OptmetabayesGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetabayesGraphN::max(self : OptmetabayesGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetabayesGraphN::to_string(self : OptmetabayesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_node_make(size : Int) -> OptmetabayesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesNode::len(self : OptmetabayesNode) -> Int { self.size }

pub fn OptmetabayesNode::get(self : OptmetabayesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesNode::set(self : OptmetabayesNode, i : Int, v : Double) -> OptmetabayesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesNode::sum(self : OptmetabayesNode) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesNode::mean(self : OptmetabayesNode) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesNode::scale(self : OptmetabayesNode, f : Double) -> OptmetabayesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesNode::add(self : OptmetabayesNode, other : OptmetabayesNode) -> OptmetabayesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesNode::copy(self : OptmetabayesNode) -> OptmetabayesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesNode::fill(self : OptmetabayesNode, v : Double) -> OptmetabayesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesNode::min(self : OptmetabayesNode) -> Double { @_common.min(self.data) }

pub fn OptmetabayesNode::max(self : OptmetabayesNode) -> Double { @_common.max(self.data) }

pub fn OptmetabayesNode::to_string(self : OptmetabayesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_edge_make(size : Int) -> OptmetabayesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesEdge::len(self : OptmetabayesEdge) -> Int { self.size }

pub fn OptmetabayesEdge::get(self : OptmetabayesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesEdge::set(self : OptmetabayesEdge, i : Int, v : Double) -> OptmetabayesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesEdge::sum(self : OptmetabayesEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesEdge::mean(self : OptmetabayesEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesEdge::scale(self : OptmetabayesEdge, f : Double) -> OptmetabayesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesEdge::add(self : OptmetabayesEdge, other : OptmetabayesEdge) -> OptmetabayesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesEdge::copy(self : OptmetabayesEdge) -> OptmetabayesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesEdge::fill(self : OptmetabayesEdge, v : Double) -> OptmetabayesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesEdge::min(self : OptmetabayesEdge) -> Double { @_common.min(self.data) }

pub fn OptmetabayesEdge::max(self : OptmetabayesEdge) -> Double { @_common.max(self.data) }

pub fn OptmetabayesEdge::to_string(self : OptmetabayesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_path_make(size : Int) -> OptmetabayesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesPath::len(self : OptmetabayesPath) -> Int { self.size }

pub fn OptmetabayesPath::get(self : OptmetabayesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesPath::set(self : OptmetabayesPath, i : Int, v : Double) -> OptmetabayesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesPath::sum(self : OptmetabayesPath) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesPath::mean(self : OptmetabayesPath) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesPath::scale(self : OptmetabayesPath, f : Double) -> OptmetabayesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesPath::add(self : OptmetabayesPath, other : OptmetabayesPath) -> OptmetabayesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesPath::copy(self : OptmetabayesPath) -> OptmetabayesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesPath::fill(self : OptmetabayesPath, v : Double) -> OptmetabayesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesPath::min(self : OptmetabayesPath) -> Double { @_common.min(self.data) }

pub fn OptmetabayesPath::max(self : OptmetabayesPath) -> Double { @_common.max(self.data) }

pub fn OptmetabayesPath::to_string(self : OptmetabayesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_cluster_make(size : Int) -> OptmetabayesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesCluster::len(self : OptmetabayesCluster) -> Int { self.size }

pub fn OptmetabayesCluster::get(self : OptmetabayesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesCluster::set(self : OptmetabayesCluster, i : Int, v : Double) -> OptmetabayesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesCluster::sum(self : OptmetabayesCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesCluster::mean(self : OptmetabayesCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesCluster::scale(self : OptmetabayesCluster, f : Double) -> OptmetabayesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesCluster::add(self : OptmetabayesCluster, other : OptmetabayesCluster) -> OptmetabayesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesCluster::copy(self : OptmetabayesCluster) -> OptmetabayesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesCluster::fill(self : OptmetabayesCluster, v : Double) -> OptmetabayesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesCluster::min(self : OptmetabayesCluster) -> Double { @_common.min(self.data) }

pub fn OptmetabayesCluster::max(self : OptmetabayesCluster) -> Double { @_common.max(self.data) }

pub fn OptmetabayesCluster::to_string(self : OptmetabayesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_model_make(size : Int) -> OptmetabayesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesModel::len(self : OptmetabayesModel) -> Int { self.size }

pub fn OptmetabayesModel::get(self : OptmetabayesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesModel::set(self : OptmetabayesModel, i : Int, v : Double) -> OptmetabayesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesModel::sum(self : OptmetabayesModel) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesModel::mean(self : OptmetabayesModel) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesModel::scale(self : OptmetabayesModel, f : Double) -> OptmetabayesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesModel::add(self : OptmetabayesModel, other : OptmetabayesModel) -> OptmetabayesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesModel::copy(self : OptmetabayesModel) -> OptmetabayesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesModel::fill(self : OptmetabayesModel, v : Double) -> OptmetabayesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesModel::min(self : OptmetabayesModel) -> Double { @_common.min(self.data) }

pub fn OptmetabayesModel::max(self : OptmetabayesModel) -> Double { @_common.max(self.data) }

pub fn OptmetabayesModel::to_string(self : OptmetabayesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_layer_make(size : Int) -> OptmetabayesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesLayer::len(self : OptmetabayesLayer) -> Int { self.size }

pub fn OptmetabayesLayer::get(self : OptmetabayesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesLayer::set(self : OptmetabayesLayer, i : Int, v : Double) -> OptmetabayesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesLayer::sum(self : OptmetabayesLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesLayer::mean(self : OptmetabayesLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesLayer::scale(self : OptmetabayesLayer, f : Double) -> OptmetabayesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesLayer::add(self : OptmetabayesLayer, other : OptmetabayesLayer) -> OptmetabayesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesLayer::copy(self : OptmetabayesLayer) -> OptmetabayesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesLayer::fill(self : OptmetabayesLayer, v : Double) -> OptmetabayesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesLayer::min(self : OptmetabayesLayer) -> Double { @_common.min(self.data) }

pub fn OptmetabayesLayer::max(self : OptmetabayesLayer) -> Double { @_common.max(self.data) }

pub fn OptmetabayesLayer::to_string(self : OptmetabayesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_buffer_make(size : Int) -> OptmetabayesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesBuffer::len(self : OptmetabayesBuffer) -> Int { self.size }

pub fn OptmetabayesBuffer::get(self : OptmetabayesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesBuffer::set(self : OptmetabayesBuffer, i : Int, v : Double) -> OptmetabayesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesBuffer::sum(self : OptmetabayesBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesBuffer::mean(self : OptmetabayesBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesBuffer::scale(self : OptmetabayesBuffer, f : Double) -> OptmetabayesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesBuffer::add(self : OptmetabayesBuffer, other : OptmetabayesBuffer) -> OptmetabayesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesBuffer::copy(self : OptmetabayesBuffer) -> OptmetabayesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesBuffer::fill(self : OptmetabayesBuffer, v : Double) -> OptmetabayesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesBuffer::min(self : OptmetabayesBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetabayesBuffer::max(self : OptmetabayesBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetabayesBuffer::to_string(self : OptmetabayesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_cursor_make(size : Int) -> OptmetabayesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesCursor::len(self : OptmetabayesCursor) -> Int { self.size }

pub fn OptmetabayesCursor::get(self : OptmetabayesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesCursor::set(self : OptmetabayesCursor, i : Int, v : Double) -> OptmetabayesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesCursor::sum(self : OptmetabayesCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesCursor::mean(self : OptmetabayesCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesCursor::scale(self : OptmetabayesCursor, f : Double) -> OptmetabayesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesCursor::add(self : OptmetabayesCursor, other : OptmetabayesCursor) -> OptmetabayesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesCursor::copy(self : OptmetabayesCursor) -> OptmetabayesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesCursor::fill(self : OptmetabayesCursor, v : Double) -> OptmetabayesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesCursor::min(self : OptmetabayesCursor) -> Double { @_common.min(self.data) }

pub fn OptmetabayesCursor::max(self : OptmetabayesCursor) -> Double { @_common.max(self.data) }

pub fn OptmetabayesCursor::to_string(self : OptmetabayesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_view_make(size : Int) -> OptmetabayesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesView::len(self : OptmetabayesView) -> Int { self.size }

pub fn OptmetabayesView::get(self : OptmetabayesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesView::set(self : OptmetabayesView, i : Int, v : Double) -> OptmetabayesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesView::sum(self : OptmetabayesView) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesView::mean(self : OptmetabayesView) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesView::scale(self : OptmetabayesView, f : Double) -> OptmetabayesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesView::add(self : OptmetabayesView, other : OptmetabayesView) -> OptmetabayesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesView::copy(self : OptmetabayesView) -> OptmetabayesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesView::fill(self : OptmetabayesView, v : Double) -> OptmetabayesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesView::min(self : OptmetabayesView) -> Double { @_common.min(self.data) }

pub fn OptmetabayesView::max(self : OptmetabayesView) -> Double { @_common.max(self.data) }

pub fn OptmetabayesView::to_string(self : OptmetabayesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_range_make(size : Int) -> OptmetabayesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesRange::len(self : OptmetabayesRange) -> Int { self.size }

pub fn OptmetabayesRange::get(self : OptmetabayesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesRange::set(self : OptmetabayesRange, i : Int, v : Double) -> OptmetabayesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesRange::sum(self : OptmetabayesRange) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesRange::mean(self : OptmetabayesRange) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesRange::scale(self : OptmetabayesRange, f : Double) -> OptmetabayesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesRange::add(self : OptmetabayesRange, other : OptmetabayesRange) -> OptmetabayesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesRange::copy(self : OptmetabayesRange) -> OptmetabayesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesRange::fill(self : OptmetabayesRange, v : Double) -> OptmetabayesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesRange::min(self : OptmetabayesRange) -> Double { @_common.min(self.data) }

pub fn OptmetabayesRange::max(self : OptmetabayesRange) -> Double { @_common.max(self.data) }

pub fn OptmetabayesRange::to_string(self : OptmetabayesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetabayesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_slice_make(size : Int) -> OptmetabayesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetabayesSlice::len(self : OptmetabayesSlice) -> Int { self.size }

pub fn OptmetabayesSlice::get(self : OptmetabayesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetabayesSlice::set(self : OptmetabayesSlice, i : Int, v : Double) -> OptmetabayesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetabayesSlice::sum(self : OptmetabayesSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetabayesSlice::mean(self : OptmetabayesSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetabayesSlice::scale(self : OptmetabayesSlice, f : Double) -> OptmetabayesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetabayesSlice::add(self : OptmetabayesSlice, other : OptmetabayesSlice) -> OptmetabayesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetabayesSlice::copy(self : OptmetabayesSlice) -> OptmetabayesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetabayesSlice::fill(self : OptmetabayesSlice, v : Double) -> OptmetabayesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetabayesSlice::min(self : OptmetabayesSlice) -> Double { @_common.min(self.data) }

pub fn OptmetabayesSlice::max(self : OptmetabayesSlice) -> Double { @_common.max(self.data) }

pub fn OptmetabayesSlice::to_string(self : OptmetabayesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

