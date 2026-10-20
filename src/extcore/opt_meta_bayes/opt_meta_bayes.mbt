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

pub fn opt_meta_bayes_frame_len(s : OptmetabayesFrame) -> Int { s.size }

pub fn opt_meta_bayes_frame_get(s : OptmetabayesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_frame_set(s : OptmetabayesFrame, i : Int, v : Double) -> OptmetabayesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_frame_sum(s : OptmetabayesFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_frame_mean(s : OptmetabayesFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_frame_scale(s : OptmetabayesFrame, f : Double) -> OptmetabayesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_frame_add(a : OptmetabayesFrame, b : OptmetabayesFrame) -> OptmetabayesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_frame_copy(s : OptmetabayesFrame) -> OptmetabayesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_frame_fill(s : OptmetabayesFrame, v : Double) -> OptmetabayesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_frame_min(s : OptmetabayesFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_frame_max(s : OptmetabayesFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_frame_to_string(s : OptmetabayesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_table_make(size : Int) -> OptmetabayesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_table_len(s : OptmetabayesTable) -> Int { s.size }

pub fn opt_meta_bayes_table_get(s : OptmetabayesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_table_set(s : OptmetabayesTable, i : Int, v : Double) -> OptmetabayesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_table_sum(s : OptmetabayesTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_table_mean(s : OptmetabayesTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_table_scale(s : OptmetabayesTable, f : Double) -> OptmetabayesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_table_add(a : OptmetabayesTable, b : OptmetabayesTable) -> OptmetabayesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_table_copy(s : OptmetabayesTable) -> OptmetabayesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_table_fill(s : OptmetabayesTable, v : Double) -> OptmetabayesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_table_min(s : OptmetabayesTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_table_max(s : OptmetabayesTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_table_to_string(s : OptmetabayesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_graphn_make(size : Int) -> OptmetabayesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_graphn_len(s : OptmetabayesGraphN) -> Int { s.size }

pub fn opt_meta_bayes_graphn_get(s : OptmetabayesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_graphn_set(s : OptmetabayesGraphN, i : Int, v : Double) -> OptmetabayesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_graphn_sum(s : OptmetabayesGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_graphn_mean(s : OptmetabayesGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_graphn_scale(s : OptmetabayesGraphN, f : Double) -> OptmetabayesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_graphn_add(a : OptmetabayesGraphN, b : OptmetabayesGraphN) -> OptmetabayesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_graphn_copy(s : OptmetabayesGraphN) -> OptmetabayesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_graphn_fill(s : OptmetabayesGraphN, v : Double) -> OptmetabayesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_graphn_min(s : OptmetabayesGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_graphn_max(s : OptmetabayesGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_graphn_to_string(s : OptmetabayesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_node_make(size : Int) -> OptmetabayesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_node_len(s : OptmetabayesNode) -> Int { s.size }

pub fn opt_meta_bayes_node_get(s : OptmetabayesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_node_set(s : OptmetabayesNode, i : Int, v : Double) -> OptmetabayesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_node_sum(s : OptmetabayesNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_node_mean(s : OptmetabayesNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_node_scale(s : OptmetabayesNode, f : Double) -> OptmetabayesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_node_add(a : OptmetabayesNode, b : OptmetabayesNode) -> OptmetabayesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_node_copy(s : OptmetabayesNode) -> OptmetabayesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_node_fill(s : OptmetabayesNode, v : Double) -> OptmetabayesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_node_min(s : OptmetabayesNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_node_max(s : OptmetabayesNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_node_to_string(s : OptmetabayesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_edge_make(size : Int) -> OptmetabayesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_edge_len(s : OptmetabayesEdge) -> Int { s.size }

pub fn opt_meta_bayes_edge_get(s : OptmetabayesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_edge_set(s : OptmetabayesEdge, i : Int, v : Double) -> OptmetabayesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_edge_sum(s : OptmetabayesEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_edge_mean(s : OptmetabayesEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_edge_scale(s : OptmetabayesEdge, f : Double) -> OptmetabayesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_edge_add(a : OptmetabayesEdge, b : OptmetabayesEdge) -> OptmetabayesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_edge_copy(s : OptmetabayesEdge) -> OptmetabayesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_edge_fill(s : OptmetabayesEdge, v : Double) -> OptmetabayesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_edge_min(s : OptmetabayesEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_edge_max(s : OptmetabayesEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_edge_to_string(s : OptmetabayesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_path_make(size : Int) -> OptmetabayesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_path_len(s : OptmetabayesPath) -> Int { s.size }

pub fn opt_meta_bayes_path_get(s : OptmetabayesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_path_set(s : OptmetabayesPath, i : Int, v : Double) -> OptmetabayesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_path_sum(s : OptmetabayesPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_path_mean(s : OptmetabayesPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_path_scale(s : OptmetabayesPath, f : Double) -> OptmetabayesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_path_add(a : OptmetabayesPath, b : OptmetabayesPath) -> OptmetabayesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_path_copy(s : OptmetabayesPath) -> OptmetabayesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_path_fill(s : OptmetabayesPath, v : Double) -> OptmetabayesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_path_min(s : OptmetabayesPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_path_max(s : OptmetabayesPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_path_to_string(s : OptmetabayesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_cluster_make(size : Int) -> OptmetabayesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_cluster_len(s : OptmetabayesCluster) -> Int { s.size }

pub fn opt_meta_bayes_cluster_get(s : OptmetabayesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_cluster_set(s : OptmetabayesCluster, i : Int, v : Double) -> OptmetabayesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cluster_sum(s : OptmetabayesCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_cluster_mean(s : OptmetabayesCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_cluster_scale(s : OptmetabayesCluster, f : Double) -> OptmetabayesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cluster_add(a : OptmetabayesCluster, b : OptmetabayesCluster) -> OptmetabayesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_cluster_copy(s : OptmetabayesCluster) -> OptmetabayesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cluster_fill(s : OptmetabayesCluster, v : Double) -> OptmetabayesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cluster_min(s : OptmetabayesCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_cluster_max(s : OptmetabayesCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_cluster_to_string(s : OptmetabayesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_model_make(size : Int) -> OptmetabayesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_model_len(s : OptmetabayesModel) -> Int { s.size }

pub fn opt_meta_bayes_model_get(s : OptmetabayesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_model_set(s : OptmetabayesModel, i : Int, v : Double) -> OptmetabayesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_model_sum(s : OptmetabayesModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_model_mean(s : OptmetabayesModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_model_scale(s : OptmetabayesModel, f : Double) -> OptmetabayesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_model_add(a : OptmetabayesModel, b : OptmetabayesModel) -> OptmetabayesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_model_copy(s : OptmetabayesModel) -> OptmetabayesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_model_fill(s : OptmetabayesModel, v : Double) -> OptmetabayesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_model_min(s : OptmetabayesModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_model_max(s : OptmetabayesModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_model_to_string(s : OptmetabayesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_layer_make(size : Int) -> OptmetabayesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_layer_len(s : OptmetabayesLayer) -> Int { s.size }

pub fn opt_meta_bayes_layer_get(s : OptmetabayesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_layer_set(s : OptmetabayesLayer, i : Int, v : Double) -> OptmetabayesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_layer_sum(s : OptmetabayesLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_layer_mean(s : OptmetabayesLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_layer_scale(s : OptmetabayesLayer, f : Double) -> OptmetabayesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_layer_add(a : OptmetabayesLayer, b : OptmetabayesLayer) -> OptmetabayesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_layer_copy(s : OptmetabayesLayer) -> OptmetabayesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_layer_fill(s : OptmetabayesLayer, v : Double) -> OptmetabayesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_layer_min(s : OptmetabayesLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_layer_max(s : OptmetabayesLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_layer_to_string(s : OptmetabayesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_buffer_make(size : Int) -> OptmetabayesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_buffer_len(s : OptmetabayesBuffer) -> Int { s.size }

pub fn opt_meta_bayes_buffer_get(s : OptmetabayesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_buffer_set(s : OptmetabayesBuffer, i : Int, v : Double) -> OptmetabayesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_buffer_sum(s : OptmetabayesBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_buffer_mean(s : OptmetabayesBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_buffer_scale(s : OptmetabayesBuffer, f : Double) -> OptmetabayesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_buffer_add(a : OptmetabayesBuffer, b : OptmetabayesBuffer) -> OptmetabayesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_buffer_copy(s : OptmetabayesBuffer) -> OptmetabayesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_buffer_fill(s : OptmetabayesBuffer, v : Double) -> OptmetabayesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_buffer_min(s : OptmetabayesBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_buffer_max(s : OptmetabayesBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_buffer_to_string(s : OptmetabayesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_cursor_make(size : Int) -> OptmetabayesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_cursor_len(s : OptmetabayesCursor) -> Int { s.size }

pub fn opt_meta_bayes_cursor_get(s : OptmetabayesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_cursor_set(s : OptmetabayesCursor, i : Int, v : Double) -> OptmetabayesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cursor_sum(s : OptmetabayesCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_cursor_mean(s : OptmetabayesCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_cursor_scale(s : OptmetabayesCursor, f : Double) -> OptmetabayesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cursor_add(a : OptmetabayesCursor, b : OptmetabayesCursor) -> OptmetabayesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_cursor_copy(s : OptmetabayesCursor) -> OptmetabayesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cursor_fill(s : OptmetabayesCursor, v : Double) -> OptmetabayesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_cursor_min(s : OptmetabayesCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_cursor_max(s : OptmetabayesCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_cursor_to_string(s : OptmetabayesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_view_make(size : Int) -> OptmetabayesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_view_len(s : OptmetabayesView) -> Int { s.size }

pub fn opt_meta_bayes_view_get(s : OptmetabayesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_view_set(s : OptmetabayesView, i : Int, v : Double) -> OptmetabayesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_view_sum(s : OptmetabayesView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_view_mean(s : OptmetabayesView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_view_scale(s : OptmetabayesView, f : Double) -> OptmetabayesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_view_add(a : OptmetabayesView, b : OptmetabayesView) -> OptmetabayesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_view_copy(s : OptmetabayesView) -> OptmetabayesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_view_fill(s : OptmetabayesView, v : Double) -> OptmetabayesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_view_min(s : OptmetabayesView) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_view_max(s : OptmetabayesView) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_view_to_string(s : OptmetabayesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_range_make(size : Int) -> OptmetabayesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_range_len(s : OptmetabayesRange) -> Int { s.size }

pub fn opt_meta_bayes_range_get(s : OptmetabayesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_range_set(s : OptmetabayesRange, i : Int, v : Double) -> OptmetabayesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_range_sum(s : OptmetabayesRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_range_mean(s : OptmetabayesRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_range_scale(s : OptmetabayesRange, f : Double) -> OptmetabayesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_range_add(a : OptmetabayesRange, b : OptmetabayesRange) -> OptmetabayesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_range_copy(s : OptmetabayesRange) -> OptmetabayesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_range_fill(s : OptmetabayesRange, v : Double) -> OptmetabayesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_range_min(s : OptmetabayesRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_range_max(s : OptmetabayesRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_range_to_string(s : OptmetabayesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_slice_make(size : Int) -> OptmetabayesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_slice_len(s : OptmetabayesSlice) -> Int { s.size }

pub fn opt_meta_bayes_slice_get(s : OptmetabayesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_slice_set(s : OptmetabayesSlice, i : Int, v : Double) -> OptmetabayesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_slice_sum(s : OptmetabayesSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_bayes_slice_mean(s : OptmetabayesSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_bayes_slice_scale(s : OptmetabayesSlice, f : Double) -> OptmetabayesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_slice_add(a : OptmetabayesSlice, b : OptmetabayesSlice) -> OptmetabayesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_bayes_slice_copy(s : OptmetabayesSlice) -> OptmetabayesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_slice_fill(s : OptmetabayesSlice, v : Double) -> OptmetabayesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_bayes_slice_min(s : OptmetabayesSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_bayes_slice_max(s : OptmetabayesSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_bayes_slice_to_string(s : OptmetabayesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

