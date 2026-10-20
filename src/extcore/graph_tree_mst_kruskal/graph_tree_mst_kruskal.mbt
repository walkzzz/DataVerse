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

pub fn GraphtreemstkruskalFrame::len(self : GraphtreemstkruskalFrame) -> Int { self.size }

pub fn GraphtreemstkruskalFrame::get(self : GraphtreemstkruskalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalFrame::set(self : GraphtreemstkruskalFrame, i : Int, v : Double) -> GraphtreemstkruskalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalFrame::sum(self : GraphtreemstkruskalFrame) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalFrame::mean(self : GraphtreemstkruskalFrame) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalFrame::scale(self : GraphtreemstkruskalFrame, f : Double) -> GraphtreemstkruskalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalFrame::add(self : GraphtreemstkruskalFrame, other : GraphtreemstkruskalFrame) -> GraphtreemstkruskalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalFrame::copy(self : GraphtreemstkruskalFrame) -> GraphtreemstkruskalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalFrame::fill(self : GraphtreemstkruskalFrame, v : Double) -> GraphtreemstkruskalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalFrame::min(self : GraphtreemstkruskalFrame) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalFrame::max(self : GraphtreemstkruskalFrame) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalFrame::to_string(self : GraphtreemstkruskalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_table_make(size : Int) -> GraphtreemstkruskalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalTable::len(self : GraphtreemstkruskalTable) -> Int { self.size }

pub fn GraphtreemstkruskalTable::get(self : GraphtreemstkruskalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalTable::set(self : GraphtreemstkruskalTable, i : Int, v : Double) -> GraphtreemstkruskalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalTable::sum(self : GraphtreemstkruskalTable) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalTable::mean(self : GraphtreemstkruskalTable) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalTable::scale(self : GraphtreemstkruskalTable, f : Double) -> GraphtreemstkruskalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalTable::add(self : GraphtreemstkruskalTable, other : GraphtreemstkruskalTable) -> GraphtreemstkruskalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalTable::copy(self : GraphtreemstkruskalTable) -> GraphtreemstkruskalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalTable::fill(self : GraphtreemstkruskalTable, v : Double) -> GraphtreemstkruskalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalTable::min(self : GraphtreemstkruskalTable) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalTable::max(self : GraphtreemstkruskalTable) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalTable::to_string(self : GraphtreemstkruskalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_graphn_make(size : Int) -> GraphtreemstkruskalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalGraphN::len(self : GraphtreemstkruskalGraphN) -> Int { self.size }

pub fn GraphtreemstkruskalGraphN::get(self : GraphtreemstkruskalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalGraphN::set(self : GraphtreemstkruskalGraphN, i : Int, v : Double) -> GraphtreemstkruskalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalGraphN::sum(self : GraphtreemstkruskalGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalGraphN::mean(self : GraphtreemstkruskalGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalGraphN::scale(self : GraphtreemstkruskalGraphN, f : Double) -> GraphtreemstkruskalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalGraphN::add(self : GraphtreemstkruskalGraphN, other : GraphtreemstkruskalGraphN) -> GraphtreemstkruskalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalGraphN::copy(self : GraphtreemstkruskalGraphN) -> GraphtreemstkruskalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalGraphN::fill(self : GraphtreemstkruskalGraphN, v : Double) -> GraphtreemstkruskalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalGraphN::min(self : GraphtreemstkruskalGraphN) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalGraphN::max(self : GraphtreemstkruskalGraphN) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalGraphN::to_string(self : GraphtreemstkruskalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_node_make(size : Int) -> GraphtreemstkruskalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalNode::len(self : GraphtreemstkruskalNode) -> Int { self.size }

pub fn GraphtreemstkruskalNode::get(self : GraphtreemstkruskalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalNode::set(self : GraphtreemstkruskalNode, i : Int, v : Double) -> GraphtreemstkruskalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalNode::sum(self : GraphtreemstkruskalNode) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalNode::mean(self : GraphtreemstkruskalNode) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalNode::scale(self : GraphtreemstkruskalNode, f : Double) -> GraphtreemstkruskalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalNode::add(self : GraphtreemstkruskalNode, other : GraphtreemstkruskalNode) -> GraphtreemstkruskalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalNode::copy(self : GraphtreemstkruskalNode) -> GraphtreemstkruskalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalNode::fill(self : GraphtreemstkruskalNode, v : Double) -> GraphtreemstkruskalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalNode::min(self : GraphtreemstkruskalNode) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalNode::max(self : GraphtreemstkruskalNode) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalNode::to_string(self : GraphtreemstkruskalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_edge_make(size : Int) -> GraphtreemstkruskalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalEdge::len(self : GraphtreemstkruskalEdge) -> Int { self.size }

pub fn GraphtreemstkruskalEdge::get(self : GraphtreemstkruskalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalEdge::set(self : GraphtreemstkruskalEdge, i : Int, v : Double) -> GraphtreemstkruskalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalEdge::sum(self : GraphtreemstkruskalEdge) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalEdge::mean(self : GraphtreemstkruskalEdge) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalEdge::scale(self : GraphtreemstkruskalEdge, f : Double) -> GraphtreemstkruskalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalEdge::add(self : GraphtreemstkruskalEdge, other : GraphtreemstkruskalEdge) -> GraphtreemstkruskalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalEdge::copy(self : GraphtreemstkruskalEdge) -> GraphtreemstkruskalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalEdge::fill(self : GraphtreemstkruskalEdge, v : Double) -> GraphtreemstkruskalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalEdge::min(self : GraphtreemstkruskalEdge) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalEdge::max(self : GraphtreemstkruskalEdge) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalEdge::to_string(self : GraphtreemstkruskalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_path_make(size : Int) -> GraphtreemstkruskalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalPath::len(self : GraphtreemstkruskalPath) -> Int { self.size }

pub fn GraphtreemstkruskalPath::get(self : GraphtreemstkruskalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalPath::set(self : GraphtreemstkruskalPath, i : Int, v : Double) -> GraphtreemstkruskalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalPath::sum(self : GraphtreemstkruskalPath) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalPath::mean(self : GraphtreemstkruskalPath) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalPath::scale(self : GraphtreemstkruskalPath, f : Double) -> GraphtreemstkruskalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalPath::add(self : GraphtreemstkruskalPath, other : GraphtreemstkruskalPath) -> GraphtreemstkruskalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalPath::copy(self : GraphtreemstkruskalPath) -> GraphtreemstkruskalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalPath::fill(self : GraphtreemstkruskalPath, v : Double) -> GraphtreemstkruskalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalPath::min(self : GraphtreemstkruskalPath) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalPath::max(self : GraphtreemstkruskalPath) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalPath::to_string(self : GraphtreemstkruskalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_cluster_make(size : Int) -> GraphtreemstkruskalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalCluster::len(self : GraphtreemstkruskalCluster) -> Int { self.size }

pub fn GraphtreemstkruskalCluster::get(self : GraphtreemstkruskalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalCluster::set(self : GraphtreemstkruskalCluster, i : Int, v : Double) -> GraphtreemstkruskalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCluster::sum(self : GraphtreemstkruskalCluster) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalCluster::mean(self : GraphtreemstkruskalCluster) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalCluster::scale(self : GraphtreemstkruskalCluster, f : Double) -> GraphtreemstkruskalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCluster::add(self : GraphtreemstkruskalCluster, other : GraphtreemstkruskalCluster) -> GraphtreemstkruskalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalCluster::copy(self : GraphtreemstkruskalCluster) -> GraphtreemstkruskalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCluster::fill(self : GraphtreemstkruskalCluster, v : Double) -> GraphtreemstkruskalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCluster::min(self : GraphtreemstkruskalCluster) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalCluster::max(self : GraphtreemstkruskalCluster) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalCluster::to_string(self : GraphtreemstkruskalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_model_make(size : Int) -> GraphtreemstkruskalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalModel::len(self : GraphtreemstkruskalModel) -> Int { self.size }

pub fn GraphtreemstkruskalModel::get(self : GraphtreemstkruskalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalModel::set(self : GraphtreemstkruskalModel, i : Int, v : Double) -> GraphtreemstkruskalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalModel::sum(self : GraphtreemstkruskalModel) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalModel::mean(self : GraphtreemstkruskalModel) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalModel::scale(self : GraphtreemstkruskalModel, f : Double) -> GraphtreemstkruskalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalModel::add(self : GraphtreemstkruskalModel, other : GraphtreemstkruskalModel) -> GraphtreemstkruskalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalModel::copy(self : GraphtreemstkruskalModel) -> GraphtreemstkruskalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalModel::fill(self : GraphtreemstkruskalModel, v : Double) -> GraphtreemstkruskalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalModel::min(self : GraphtreemstkruskalModel) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalModel::max(self : GraphtreemstkruskalModel) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalModel::to_string(self : GraphtreemstkruskalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_layer_make(size : Int) -> GraphtreemstkruskalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalLayer::len(self : GraphtreemstkruskalLayer) -> Int { self.size }

pub fn GraphtreemstkruskalLayer::get(self : GraphtreemstkruskalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalLayer::set(self : GraphtreemstkruskalLayer, i : Int, v : Double) -> GraphtreemstkruskalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalLayer::sum(self : GraphtreemstkruskalLayer) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalLayer::mean(self : GraphtreemstkruskalLayer) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalLayer::scale(self : GraphtreemstkruskalLayer, f : Double) -> GraphtreemstkruskalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalLayer::add(self : GraphtreemstkruskalLayer, other : GraphtreemstkruskalLayer) -> GraphtreemstkruskalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalLayer::copy(self : GraphtreemstkruskalLayer) -> GraphtreemstkruskalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalLayer::fill(self : GraphtreemstkruskalLayer, v : Double) -> GraphtreemstkruskalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalLayer::min(self : GraphtreemstkruskalLayer) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalLayer::max(self : GraphtreemstkruskalLayer) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalLayer::to_string(self : GraphtreemstkruskalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_buffer_make(size : Int) -> GraphtreemstkruskalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalBuffer::len(self : GraphtreemstkruskalBuffer) -> Int { self.size }

pub fn GraphtreemstkruskalBuffer::get(self : GraphtreemstkruskalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalBuffer::set(self : GraphtreemstkruskalBuffer, i : Int, v : Double) -> GraphtreemstkruskalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalBuffer::sum(self : GraphtreemstkruskalBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalBuffer::mean(self : GraphtreemstkruskalBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalBuffer::scale(self : GraphtreemstkruskalBuffer, f : Double) -> GraphtreemstkruskalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalBuffer::add(self : GraphtreemstkruskalBuffer, other : GraphtreemstkruskalBuffer) -> GraphtreemstkruskalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalBuffer::copy(self : GraphtreemstkruskalBuffer) -> GraphtreemstkruskalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalBuffer::fill(self : GraphtreemstkruskalBuffer, v : Double) -> GraphtreemstkruskalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalBuffer::min(self : GraphtreemstkruskalBuffer) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalBuffer::max(self : GraphtreemstkruskalBuffer) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalBuffer::to_string(self : GraphtreemstkruskalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_cursor_make(size : Int) -> GraphtreemstkruskalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalCursor::len(self : GraphtreemstkruskalCursor) -> Int { self.size }

pub fn GraphtreemstkruskalCursor::get(self : GraphtreemstkruskalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalCursor::set(self : GraphtreemstkruskalCursor, i : Int, v : Double) -> GraphtreemstkruskalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCursor::sum(self : GraphtreemstkruskalCursor) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalCursor::mean(self : GraphtreemstkruskalCursor) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalCursor::scale(self : GraphtreemstkruskalCursor, f : Double) -> GraphtreemstkruskalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCursor::add(self : GraphtreemstkruskalCursor, other : GraphtreemstkruskalCursor) -> GraphtreemstkruskalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalCursor::copy(self : GraphtreemstkruskalCursor) -> GraphtreemstkruskalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCursor::fill(self : GraphtreemstkruskalCursor, v : Double) -> GraphtreemstkruskalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalCursor::min(self : GraphtreemstkruskalCursor) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalCursor::max(self : GraphtreemstkruskalCursor) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalCursor::to_string(self : GraphtreemstkruskalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_view_make(size : Int) -> GraphtreemstkruskalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalView::len(self : GraphtreemstkruskalView) -> Int { self.size }

pub fn GraphtreemstkruskalView::get(self : GraphtreemstkruskalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalView::set(self : GraphtreemstkruskalView, i : Int, v : Double) -> GraphtreemstkruskalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalView::sum(self : GraphtreemstkruskalView) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalView::mean(self : GraphtreemstkruskalView) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalView::scale(self : GraphtreemstkruskalView, f : Double) -> GraphtreemstkruskalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalView::add(self : GraphtreemstkruskalView, other : GraphtreemstkruskalView) -> GraphtreemstkruskalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalView::copy(self : GraphtreemstkruskalView) -> GraphtreemstkruskalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalView::fill(self : GraphtreemstkruskalView, v : Double) -> GraphtreemstkruskalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalView::min(self : GraphtreemstkruskalView) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalView::max(self : GraphtreemstkruskalView) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalView::to_string(self : GraphtreemstkruskalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_range_make(size : Int) -> GraphtreemstkruskalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalRange::len(self : GraphtreemstkruskalRange) -> Int { self.size }

pub fn GraphtreemstkruskalRange::get(self : GraphtreemstkruskalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalRange::set(self : GraphtreemstkruskalRange, i : Int, v : Double) -> GraphtreemstkruskalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalRange::sum(self : GraphtreemstkruskalRange) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalRange::mean(self : GraphtreemstkruskalRange) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalRange::scale(self : GraphtreemstkruskalRange, f : Double) -> GraphtreemstkruskalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalRange::add(self : GraphtreemstkruskalRange, other : GraphtreemstkruskalRange) -> GraphtreemstkruskalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalRange::copy(self : GraphtreemstkruskalRange) -> GraphtreemstkruskalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalRange::fill(self : GraphtreemstkruskalRange, v : Double) -> GraphtreemstkruskalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalRange::min(self : GraphtreemstkruskalRange) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalRange::max(self : GraphtreemstkruskalRange) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalRange::to_string(self : GraphtreemstkruskalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_slice_make(size : Int) -> GraphtreemstkruskalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstkruskalSlice::len(self : GraphtreemstkruskalSlice) -> Int { self.size }

pub fn GraphtreemstkruskalSlice::get(self : GraphtreemstkruskalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstkruskalSlice::set(self : GraphtreemstkruskalSlice, i : Int, v : Double) -> GraphtreemstkruskalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalSlice::sum(self : GraphtreemstkruskalSlice) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstkruskalSlice::mean(self : GraphtreemstkruskalSlice) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstkruskalSlice::scale(self : GraphtreemstkruskalSlice, f : Double) -> GraphtreemstkruskalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalSlice::add(self : GraphtreemstkruskalSlice, other : GraphtreemstkruskalSlice) -> GraphtreemstkruskalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstkruskalSlice::copy(self : GraphtreemstkruskalSlice) -> GraphtreemstkruskalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalSlice::fill(self : GraphtreemstkruskalSlice, v : Double) -> GraphtreemstkruskalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstkruskalSlice::min(self : GraphtreemstkruskalSlice) -> Double { @_common.min(self.data) }

pub fn GraphtreemstkruskalSlice::max(self : GraphtreemstkruskalSlice) -> Double { @_common.max(self.data) }

pub fn GraphtreemstkruskalSlice::to_string(self : GraphtreemstkruskalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

