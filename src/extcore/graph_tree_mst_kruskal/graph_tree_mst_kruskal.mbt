///===
/// extcore/graph_tree_mst_kruskal

pub(all) struct GraphtreemstkruskalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_kruskal_make_point(x : Double, y : Double) -> GraphtreemstkruskalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_kruskal_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstkruskalPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreemstkruskalPoint::x(self : GraphtreemstkruskalPoint) -> Double { self.x }

pub fn GraphtreemstkruskalPoint::y(self : GraphtreemstkruskalPoint) -> Double { self.y }

pub fn GraphtreemstkruskalPoint::z(self : GraphtreemstkruskalPoint) -> Double { self.z }

pub fn GraphtreemstkruskalPoint::label(self : GraphtreemstkruskalPoint) -> Int { self.label }

pub fn GraphtreemstkruskalPoint::dist(self : GraphtreemstkruskalPoint, other : GraphtreemstkruskalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreemstkruskalPoint::add(self : GraphtreemstkruskalPoint, other : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreemstkruskalPoint::sub(self : GraphtreemstkruskalPoint, other : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreemstkruskalPoint::scale(self : GraphtreemstkruskalPoint, s : Double) -> GraphtreemstkruskalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreemstkruskalPoint::dot(self : GraphtreemstkruskalPoint, other : GraphtreemstkruskalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreemstkruskalPoint::cross(self : GraphtreemstkruskalPoint, other : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreemstkruskalPoint::norm(self : GraphtreemstkruskalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreemstkruskalPoint::normalize(self : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstkruskalPoint::negate(self : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreemstkruskalPoint::mid(self : GraphtreemstkruskalPoint, other : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreemstkruskalPoint::lerp(self : GraphtreemstkruskalPoint, other : GraphtreemstkruskalPoint, t : Double) -> GraphtreemstkruskalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreemstkruskalPoint::to_string(self : GraphtreemstkruskalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_kruskal_make_series(vals : Array[Double], name : String) -> GraphtreemstkruskalSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreemstkruskalSeries::len(self : GraphtreemstkruskalSeries) -> Int { self.vals.length() }

pub fn GraphtreemstkruskalSeries::sum(self : GraphtreemstkruskalSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreemstkruskalSeries::mean(self : GraphtreemstkruskalSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreemstkruskalSeries::min(self : GraphtreemstkruskalSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreemstkruskalSeries::max(self : GraphtreemstkruskalSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreemstkruskalSeries::range(self : GraphtreemstkruskalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreemstkruskalSeries::variance(self : GraphtreemstkruskalSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreemstkruskalSeries::std(self : GraphtreemstkruskalSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreemstkruskalSeries::median(self : GraphtreemstkruskalSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreemstkruskalSeries::scale(self : GraphtreemstkruskalSeries, f : Double) -> GraphtreemstkruskalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreemstkruskalSeries::add(self : GraphtreemstkruskalSeries, other : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreemstkruskalSeries::sub(self : GraphtreemstkruskalSeries, other : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreemstkruskalSeries::normalize(self : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreemstkruskalSeries::cumsum(self : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreemstkruskalSeries::to_string(self : GraphtreemstkruskalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstkruskalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_kruskal_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstkruskalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_kruskal_matrix_identity(n : Int) -> GraphtreemstkruskalMatrix {
  let m = graph_tree_mst_kruskal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreemstkruskalMatrix::get(self : GraphtreemstkruskalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreemstkruskalMatrix::transpose(self : GraphtreemstkruskalMatrix) -> GraphtreemstkruskalMatrix {
  let result = graph_tree_mst_kruskal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreemstkruskalMatrix::add(self : GraphtreemstkruskalMatrix, other : GraphtreemstkruskalMatrix) -> GraphtreemstkruskalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_mst_kruskal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreemstkruskalMatrix::scale(self : GraphtreemstkruskalMatrix, s : Double) -> GraphtreemstkruskalMatrix {
  let result = graph_tree_mst_kruskal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreemstkruskalMatrix::multiply(self : GraphtreemstkruskalMatrix, other : GraphtreemstkruskalMatrix) -> GraphtreemstkruskalMatrix {
  if self.cols != other.rows { return graph_tree_mst_kruskal_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_mst_kruskal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreemstkruskalMatrix::trace(self : GraphtreemstkruskalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreemstkruskalMatrix::det(self : GraphtreemstkruskalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreemstkruskalMatrix::norm(self : GraphtreemstkruskalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreemstkruskalMatrix::to_string(self : GraphtreemstkruskalMatrix) -> String {
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

pub(all) struct GraphtreemstkruskalVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_kruskal_make_vector(comps : Array[Double]) -> GraphtreemstkruskalVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_kruskal_vector_zero(dim : Int) -> GraphtreemstkruskalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreemstkruskalVector::add(self : GraphtreemstkruskalVector, other : GraphtreemstkruskalVector) -> GraphtreemstkruskalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstkruskalVector::sub(self : GraphtreemstkruskalVector, other : GraphtreemstkruskalVector) -> GraphtreemstkruskalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstkruskalVector::scale(self : GraphtreemstkruskalVector, s : Double) -> GraphtreemstkruskalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreemstkruskalVector::dot(self : GraphtreemstkruskalVector, other : GraphtreemstkruskalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreemstkruskalVector::norm(self : GraphtreemstkruskalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreemstkruskalVector::normalize(self : GraphtreemstkruskalVector) -> GraphtreemstkruskalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstkruskalVector::dist(self : GraphtreemstkruskalVector, other : GraphtreemstkruskalVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreemstkruskalVector::to_string(self : GraphtreemstkruskalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_kruskal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_mst_kruskal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_mst_kruskal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_mst_kruskal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_mst_kruskal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_mst_kruskal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_mst_kruskal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_mst_kruskal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_mst_kruskal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_mst_kruskal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_mst_kruskal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_mst_kruskal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_mst_kruskal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_mst_kruskal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_mst_kruskal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_mst_kruskal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_mst_kruskal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_mst_kruskal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_mst_kruskal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_mst_kruskal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_mst_kruskal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_mst_kruskal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_mst_kruskal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_mst_kruskal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_mst_kruskal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_mst_kruskal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_mst_kruskal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_mst_kruskal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_mst_kruskal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreemstkruskalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_frame_make(size : Int) -> GraphtreemstkruskalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_frame_len(s : GraphtreemstkruskalFrame) -> Int { s.size }

pub fn graph_tree_mst_kruskal_frame_get(s : GraphtreemstkruskalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_frame_set(s : GraphtreemstkruskalFrame, i : Int, v : Double) -> GraphtreemstkruskalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_frame_sum(s : GraphtreemstkruskalFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_frame_mean(s : GraphtreemstkruskalFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_frame_scale(s : GraphtreemstkruskalFrame, f : Double) -> GraphtreemstkruskalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_frame_add(a : GraphtreemstkruskalFrame, b : GraphtreemstkruskalFrame) -> GraphtreemstkruskalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_frame_copy(s : GraphtreemstkruskalFrame) -> GraphtreemstkruskalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_frame_fill(s : GraphtreemstkruskalFrame, v : Double) -> GraphtreemstkruskalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_frame_min(s : GraphtreemstkruskalFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_frame_max(s : GraphtreemstkruskalFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_frame_to_string(s : GraphtreemstkruskalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_table_make(size : Int) -> GraphtreemstkruskalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_table_len(s : GraphtreemstkruskalTable) -> Int { s.size }

pub fn graph_tree_mst_kruskal_table_get(s : GraphtreemstkruskalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_table_set(s : GraphtreemstkruskalTable, i : Int, v : Double) -> GraphtreemstkruskalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_table_sum(s : GraphtreemstkruskalTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_table_mean(s : GraphtreemstkruskalTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_table_scale(s : GraphtreemstkruskalTable, f : Double) -> GraphtreemstkruskalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_table_add(a : GraphtreemstkruskalTable, b : GraphtreemstkruskalTable) -> GraphtreemstkruskalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_table_copy(s : GraphtreemstkruskalTable) -> GraphtreemstkruskalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_table_fill(s : GraphtreemstkruskalTable, v : Double) -> GraphtreemstkruskalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_table_min(s : GraphtreemstkruskalTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_table_max(s : GraphtreemstkruskalTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_table_to_string(s : GraphtreemstkruskalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_graphn_make(size : Int) -> GraphtreemstkruskalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_graphn_len(s : GraphtreemstkruskalGraphN) -> Int { s.size }

pub fn graph_tree_mst_kruskal_graphn_get(s : GraphtreemstkruskalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_graphn_set(s : GraphtreemstkruskalGraphN, i : Int, v : Double) -> GraphtreemstkruskalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_graphn_sum(s : GraphtreemstkruskalGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_graphn_mean(s : GraphtreemstkruskalGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_graphn_scale(s : GraphtreemstkruskalGraphN, f : Double) -> GraphtreemstkruskalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_graphn_add(a : GraphtreemstkruskalGraphN, b : GraphtreemstkruskalGraphN) -> GraphtreemstkruskalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_graphn_copy(s : GraphtreemstkruskalGraphN) -> GraphtreemstkruskalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_graphn_fill(s : GraphtreemstkruskalGraphN, v : Double) -> GraphtreemstkruskalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_graphn_min(s : GraphtreemstkruskalGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_graphn_max(s : GraphtreemstkruskalGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_graphn_to_string(s : GraphtreemstkruskalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_node_make(size : Int) -> GraphtreemstkruskalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_node_len(s : GraphtreemstkruskalNode) -> Int { s.size }

pub fn graph_tree_mst_kruskal_node_get(s : GraphtreemstkruskalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_node_set(s : GraphtreemstkruskalNode, i : Int, v : Double) -> GraphtreemstkruskalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_node_sum(s : GraphtreemstkruskalNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_node_mean(s : GraphtreemstkruskalNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_node_scale(s : GraphtreemstkruskalNode, f : Double) -> GraphtreemstkruskalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_node_add(a : GraphtreemstkruskalNode, b : GraphtreemstkruskalNode) -> GraphtreemstkruskalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_node_copy(s : GraphtreemstkruskalNode) -> GraphtreemstkruskalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_node_fill(s : GraphtreemstkruskalNode, v : Double) -> GraphtreemstkruskalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_node_min(s : GraphtreemstkruskalNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_node_max(s : GraphtreemstkruskalNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_node_to_string(s : GraphtreemstkruskalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_edge_make(size : Int) -> GraphtreemstkruskalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_edge_len(s : GraphtreemstkruskalEdge) -> Int { s.size }

pub fn graph_tree_mst_kruskal_edge_get(s : GraphtreemstkruskalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_edge_set(s : GraphtreemstkruskalEdge, i : Int, v : Double) -> GraphtreemstkruskalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_edge_sum(s : GraphtreemstkruskalEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_edge_mean(s : GraphtreemstkruskalEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_edge_scale(s : GraphtreemstkruskalEdge, f : Double) -> GraphtreemstkruskalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_edge_add(a : GraphtreemstkruskalEdge, b : GraphtreemstkruskalEdge) -> GraphtreemstkruskalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_edge_copy(s : GraphtreemstkruskalEdge) -> GraphtreemstkruskalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_edge_fill(s : GraphtreemstkruskalEdge, v : Double) -> GraphtreemstkruskalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_edge_min(s : GraphtreemstkruskalEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_edge_max(s : GraphtreemstkruskalEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_edge_to_string(s : GraphtreemstkruskalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_path_make(size : Int) -> GraphtreemstkruskalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_path_len(s : GraphtreemstkruskalPath) -> Int { s.size }

pub fn graph_tree_mst_kruskal_path_get(s : GraphtreemstkruskalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_path_set(s : GraphtreemstkruskalPath, i : Int, v : Double) -> GraphtreemstkruskalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_path_sum(s : GraphtreemstkruskalPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_path_mean(s : GraphtreemstkruskalPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_path_scale(s : GraphtreemstkruskalPath, f : Double) -> GraphtreemstkruskalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_path_add(a : GraphtreemstkruskalPath, b : GraphtreemstkruskalPath) -> GraphtreemstkruskalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_path_copy(s : GraphtreemstkruskalPath) -> GraphtreemstkruskalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_path_fill(s : GraphtreemstkruskalPath, v : Double) -> GraphtreemstkruskalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_path_min(s : GraphtreemstkruskalPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_path_max(s : GraphtreemstkruskalPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_path_to_string(s : GraphtreemstkruskalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_cluster_make(size : Int) -> GraphtreemstkruskalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_cluster_len(s : GraphtreemstkruskalCluster) -> Int { s.size }

pub fn graph_tree_mst_kruskal_cluster_get(s : GraphtreemstkruskalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_cluster_set(s : GraphtreemstkruskalCluster, i : Int, v : Double) -> GraphtreemstkruskalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cluster_sum(s : GraphtreemstkruskalCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_cluster_mean(s : GraphtreemstkruskalCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_cluster_scale(s : GraphtreemstkruskalCluster, f : Double) -> GraphtreemstkruskalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cluster_add(a : GraphtreemstkruskalCluster, b : GraphtreemstkruskalCluster) -> GraphtreemstkruskalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_cluster_copy(s : GraphtreemstkruskalCluster) -> GraphtreemstkruskalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cluster_fill(s : GraphtreemstkruskalCluster, v : Double) -> GraphtreemstkruskalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cluster_min(s : GraphtreemstkruskalCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_cluster_max(s : GraphtreemstkruskalCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_cluster_to_string(s : GraphtreemstkruskalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_model_make(size : Int) -> GraphtreemstkruskalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_model_len(s : GraphtreemstkruskalModel) -> Int { s.size }

pub fn graph_tree_mst_kruskal_model_get(s : GraphtreemstkruskalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_model_set(s : GraphtreemstkruskalModel, i : Int, v : Double) -> GraphtreemstkruskalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_model_sum(s : GraphtreemstkruskalModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_model_mean(s : GraphtreemstkruskalModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_model_scale(s : GraphtreemstkruskalModel, f : Double) -> GraphtreemstkruskalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_model_add(a : GraphtreemstkruskalModel, b : GraphtreemstkruskalModel) -> GraphtreemstkruskalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_model_copy(s : GraphtreemstkruskalModel) -> GraphtreemstkruskalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_model_fill(s : GraphtreemstkruskalModel, v : Double) -> GraphtreemstkruskalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_model_min(s : GraphtreemstkruskalModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_model_max(s : GraphtreemstkruskalModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_model_to_string(s : GraphtreemstkruskalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_layer_make(size : Int) -> GraphtreemstkruskalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_layer_len(s : GraphtreemstkruskalLayer) -> Int { s.size }

pub fn graph_tree_mst_kruskal_layer_get(s : GraphtreemstkruskalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_layer_set(s : GraphtreemstkruskalLayer, i : Int, v : Double) -> GraphtreemstkruskalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_layer_sum(s : GraphtreemstkruskalLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_layer_mean(s : GraphtreemstkruskalLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_layer_scale(s : GraphtreemstkruskalLayer, f : Double) -> GraphtreemstkruskalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_layer_add(a : GraphtreemstkruskalLayer, b : GraphtreemstkruskalLayer) -> GraphtreemstkruskalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_layer_copy(s : GraphtreemstkruskalLayer) -> GraphtreemstkruskalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_layer_fill(s : GraphtreemstkruskalLayer, v : Double) -> GraphtreemstkruskalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_layer_min(s : GraphtreemstkruskalLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_layer_max(s : GraphtreemstkruskalLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_layer_to_string(s : GraphtreemstkruskalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_buffer_make(size : Int) -> GraphtreemstkruskalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_buffer_len(s : GraphtreemstkruskalBuffer) -> Int { s.size }

pub fn graph_tree_mst_kruskal_buffer_get(s : GraphtreemstkruskalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_buffer_set(s : GraphtreemstkruskalBuffer, i : Int, v : Double) -> GraphtreemstkruskalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_buffer_sum(s : GraphtreemstkruskalBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_buffer_mean(s : GraphtreemstkruskalBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_buffer_scale(s : GraphtreemstkruskalBuffer, f : Double) -> GraphtreemstkruskalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_buffer_add(a : GraphtreemstkruskalBuffer, b : GraphtreemstkruskalBuffer) -> GraphtreemstkruskalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_buffer_copy(s : GraphtreemstkruskalBuffer) -> GraphtreemstkruskalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_buffer_fill(s : GraphtreemstkruskalBuffer, v : Double) -> GraphtreemstkruskalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_buffer_min(s : GraphtreemstkruskalBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_buffer_max(s : GraphtreemstkruskalBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_buffer_to_string(s : GraphtreemstkruskalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_cursor_make(size : Int) -> GraphtreemstkruskalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_cursor_len(s : GraphtreemstkruskalCursor) -> Int { s.size }

pub fn graph_tree_mst_kruskal_cursor_get(s : GraphtreemstkruskalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_cursor_set(s : GraphtreemstkruskalCursor, i : Int, v : Double) -> GraphtreemstkruskalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cursor_sum(s : GraphtreemstkruskalCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_cursor_mean(s : GraphtreemstkruskalCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_cursor_scale(s : GraphtreemstkruskalCursor, f : Double) -> GraphtreemstkruskalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cursor_add(a : GraphtreemstkruskalCursor, b : GraphtreemstkruskalCursor) -> GraphtreemstkruskalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_cursor_copy(s : GraphtreemstkruskalCursor) -> GraphtreemstkruskalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cursor_fill(s : GraphtreemstkruskalCursor, v : Double) -> GraphtreemstkruskalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_cursor_min(s : GraphtreemstkruskalCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_cursor_max(s : GraphtreemstkruskalCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_cursor_to_string(s : GraphtreemstkruskalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_view_make(size : Int) -> GraphtreemstkruskalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_view_len(s : GraphtreemstkruskalView) -> Int { s.size }

pub fn graph_tree_mst_kruskal_view_get(s : GraphtreemstkruskalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_view_set(s : GraphtreemstkruskalView, i : Int, v : Double) -> GraphtreemstkruskalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_view_sum(s : GraphtreemstkruskalView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_view_mean(s : GraphtreemstkruskalView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_view_scale(s : GraphtreemstkruskalView, f : Double) -> GraphtreemstkruskalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_view_add(a : GraphtreemstkruskalView, b : GraphtreemstkruskalView) -> GraphtreemstkruskalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_view_copy(s : GraphtreemstkruskalView) -> GraphtreemstkruskalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_view_fill(s : GraphtreemstkruskalView, v : Double) -> GraphtreemstkruskalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_view_min(s : GraphtreemstkruskalView) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_view_max(s : GraphtreemstkruskalView) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_view_to_string(s : GraphtreemstkruskalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_range_make(size : Int) -> GraphtreemstkruskalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_range_len(s : GraphtreemstkruskalRange) -> Int { s.size }

pub fn graph_tree_mst_kruskal_range_get(s : GraphtreemstkruskalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_range_set(s : GraphtreemstkruskalRange, i : Int, v : Double) -> GraphtreemstkruskalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_range_sum(s : GraphtreemstkruskalRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_range_mean(s : GraphtreemstkruskalRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_range_scale(s : GraphtreemstkruskalRange, f : Double) -> GraphtreemstkruskalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_range_add(a : GraphtreemstkruskalRange, b : GraphtreemstkruskalRange) -> GraphtreemstkruskalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_range_copy(s : GraphtreemstkruskalRange) -> GraphtreemstkruskalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_range_fill(s : GraphtreemstkruskalRange, v : Double) -> GraphtreemstkruskalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_range_min(s : GraphtreemstkruskalRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_range_max(s : GraphtreemstkruskalRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_range_to_string(s : GraphtreemstkruskalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_slice_make(size : Int) -> GraphtreemstkruskalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_slice_len(s : GraphtreemstkruskalSlice) -> Int { s.size }

pub fn graph_tree_mst_kruskal_slice_get(s : GraphtreemstkruskalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_slice_set(s : GraphtreemstkruskalSlice, i : Int, v : Double) -> GraphtreemstkruskalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_slice_sum(s : GraphtreemstkruskalSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_kruskal_slice_mean(s : GraphtreemstkruskalSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_kruskal_slice_scale(s : GraphtreemstkruskalSlice, f : Double) -> GraphtreemstkruskalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_slice_add(a : GraphtreemstkruskalSlice, b : GraphtreemstkruskalSlice) -> GraphtreemstkruskalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_kruskal_slice_copy(s : GraphtreemstkruskalSlice) -> GraphtreemstkruskalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_slice_fill(s : GraphtreemstkruskalSlice, v : Double) -> GraphtreemstkruskalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_kruskal_slice_min(s : GraphtreemstkruskalSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_kruskal_slice_max(s : GraphtreemstkruskalSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_kruskal_slice_to_string(s : GraphtreemstkruskalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

