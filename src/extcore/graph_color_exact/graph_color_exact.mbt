///===
/// extcore/graph_color_exact

pub(all) struct GraphcolorexactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_exact_make_point(x : Double, y : Double) -> GraphcolorexactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_exact_make_point3(x : Double, y : Double, z : Double) -> GraphcolorexactPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorexactPoint::x(self : GraphcolorexactPoint) -> Double { self.x }

pub fn GraphcolorexactPoint::y(self : GraphcolorexactPoint) -> Double { self.y }

pub fn GraphcolorexactPoint::z(self : GraphcolorexactPoint) -> Double { self.z }

pub fn GraphcolorexactPoint::label(self : GraphcolorexactPoint) -> Int { self.label }

pub fn GraphcolorexactPoint::dist(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorexactPoint::add(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorexactPoint::sub(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorexactPoint::scale(self : GraphcolorexactPoint, s : Double) -> GraphcolorexactPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorexactPoint::dot(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorexactPoint::cross(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorexactPoint::norm(self : GraphcolorexactPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorexactPoint::normalize(self : GraphcolorexactPoint) -> GraphcolorexactPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorexactPoint::negate(self : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorexactPoint::mid(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorexactPoint::lerp(self : GraphcolorexactPoint, other : GraphcolorexactPoint, t : Double) -> GraphcolorexactPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorexactPoint::to_string(self : GraphcolorexactPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorexactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_exact_make_series(vals : Array[Double], name : String) -> GraphcolorexactSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorexactSeries::len(self : GraphcolorexactSeries) -> Int { self.vals.length() }

pub fn GraphcolorexactSeries::sum(self : GraphcolorexactSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorexactSeries::mean(self : GraphcolorexactSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorexactSeries::min(self : GraphcolorexactSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorexactSeries::max(self : GraphcolorexactSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorexactSeries::range(self : GraphcolorexactSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorexactSeries::variance(self : GraphcolorexactSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorexactSeries::std(self : GraphcolorexactSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorexactSeries::median(self : GraphcolorexactSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorexactSeries::scale(self : GraphcolorexactSeries, f : Double) -> GraphcolorexactSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorexactSeries::add(self : GraphcolorexactSeries, other : GraphcolorexactSeries) -> GraphcolorexactSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorexactSeries::sub(self : GraphcolorexactSeries, other : GraphcolorexactSeries) -> GraphcolorexactSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorexactSeries::normalize(self : GraphcolorexactSeries) -> GraphcolorexactSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorexactSeries::cumsum(self : GraphcolorexactSeries) -> GraphcolorexactSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorexactSeries::to_string(self : GraphcolorexactSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorexactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_exact_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorexactMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_exact_matrix_identity(n : Int) -> GraphcolorexactMatrix {
  let m = graph_color_exact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorexactMatrix::get(self : GraphcolorexactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorexactMatrix::transpose(self : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  let result = graph_color_exact_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorexactMatrix::add(self : GraphcolorexactMatrix, other : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_exact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorexactMatrix::scale(self : GraphcolorexactMatrix, s : Double) -> GraphcolorexactMatrix {
  let result = graph_color_exact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorexactMatrix::multiply(self : GraphcolorexactMatrix, other : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  if self.cols != other.rows { return graph_color_exact_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_exact_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorexactMatrix::trace(self : GraphcolorexactMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorexactMatrix::det(self : GraphcolorexactMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorexactMatrix::norm(self : GraphcolorexactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorexactMatrix::to_string(self : GraphcolorexactMatrix) -> String {
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

pub(all) struct GraphcolorexactVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_exact_make_vector(comps : Array[Double]) -> GraphcolorexactVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_exact_vector_zero(dim : Int) -> GraphcolorexactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorexactVector::add(self : GraphcolorexactVector, other : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorexactVector::sub(self : GraphcolorexactVector, other : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorexactVector::scale(self : GraphcolorexactVector, s : Double) -> GraphcolorexactVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorexactVector::dot(self : GraphcolorexactVector, other : GraphcolorexactVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorexactVector::norm(self : GraphcolorexactVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorexactVector::normalize(self : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorexactVector::dist(self : GraphcolorexactVector, other : GraphcolorexactVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorexactVector::to_string(self : GraphcolorexactVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_exact_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_exact_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_exact_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_exact_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_exact_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_exact_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_exact_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_exact_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_exact_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_exact_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_exact_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_exact_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_exact_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_exact_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_exact_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_exact_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_exact_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_exact_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_exact_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_exact_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_exact_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_exact_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_exact_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_exact_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_exact_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_exact_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_exact_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_exact_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_exact_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorexactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_frame_make(size : Int) -> GraphcolorexactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_frame_len(s : GraphcolorexactFrame) -> Int { s.size }

pub fn graph_color_exact_frame_get(s : GraphcolorexactFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_frame_set(s : GraphcolorexactFrame, i : Int, v : Double) -> GraphcolorexactFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_frame_sum(s : GraphcolorexactFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_frame_mean(s : GraphcolorexactFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_frame_scale(s : GraphcolorexactFrame, f : Double) -> GraphcolorexactFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_frame_add(a : GraphcolorexactFrame, b : GraphcolorexactFrame) -> GraphcolorexactFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_frame_copy(s : GraphcolorexactFrame) -> GraphcolorexactFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_frame_fill(s : GraphcolorexactFrame, v : Double) -> GraphcolorexactFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_frame_min(s : GraphcolorexactFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_frame_max(s : GraphcolorexactFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_frame_to_string(s : GraphcolorexactFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_table_make(size : Int) -> GraphcolorexactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_table_len(s : GraphcolorexactTable) -> Int { s.size }

pub fn graph_color_exact_table_get(s : GraphcolorexactTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_table_set(s : GraphcolorexactTable, i : Int, v : Double) -> GraphcolorexactTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_table_sum(s : GraphcolorexactTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_table_mean(s : GraphcolorexactTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_table_scale(s : GraphcolorexactTable, f : Double) -> GraphcolorexactTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_table_add(a : GraphcolorexactTable, b : GraphcolorexactTable) -> GraphcolorexactTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_table_copy(s : GraphcolorexactTable) -> GraphcolorexactTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_table_fill(s : GraphcolorexactTable, v : Double) -> GraphcolorexactTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_table_min(s : GraphcolorexactTable) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_table_max(s : GraphcolorexactTable) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_table_to_string(s : GraphcolorexactTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_graphn_make(size : Int) -> GraphcolorexactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_graphn_len(s : GraphcolorexactGraphN) -> Int { s.size }

pub fn graph_color_exact_graphn_get(s : GraphcolorexactGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_graphn_set(s : GraphcolorexactGraphN, i : Int, v : Double) -> GraphcolorexactGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_graphn_sum(s : GraphcolorexactGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_graphn_mean(s : GraphcolorexactGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_graphn_scale(s : GraphcolorexactGraphN, f : Double) -> GraphcolorexactGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_graphn_add(a : GraphcolorexactGraphN, b : GraphcolorexactGraphN) -> GraphcolorexactGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_graphn_copy(s : GraphcolorexactGraphN) -> GraphcolorexactGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_graphn_fill(s : GraphcolorexactGraphN, v : Double) -> GraphcolorexactGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_graphn_min(s : GraphcolorexactGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_graphn_max(s : GraphcolorexactGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_graphn_to_string(s : GraphcolorexactGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_node_make(size : Int) -> GraphcolorexactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_node_len(s : GraphcolorexactNode) -> Int { s.size }

pub fn graph_color_exact_node_get(s : GraphcolorexactNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_node_set(s : GraphcolorexactNode, i : Int, v : Double) -> GraphcolorexactNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_node_sum(s : GraphcolorexactNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_node_mean(s : GraphcolorexactNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_node_scale(s : GraphcolorexactNode, f : Double) -> GraphcolorexactNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_node_add(a : GraphcolorexactNode, b : GraphcolorexactNode) -> GraphcolorexactNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_node_copy(s : GraphcolorexactNode) -> GraphcolorexactNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_node_fill(s : GraphcolorexactNode, v : Double) -> GraphcolorexactNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_node_min(s : GraphcolorexactNode) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_node_max(s : GraphcolorexactNode) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_node_to_string(s : GraphcolorexactNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_edge_make(size : Int) -> GraphcolorexactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_edge_len(s : GraphcolorexactEdge) -> Int { s.size }

pub fn graph_color_exact_edge_get(s : GraphcolorexactEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_edge_set(s : GraphcolorexactEdge, i : Int, v : Double) -> GraphcolorexactEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_edge_sum(s : GraphcolorexactEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_edge_mean(s : GraphcolorexactEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_edge_scale(s : GraphcolorexactEdge, f : Double) -> GraphcolorexactEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_edge_add(a : GraphcolorexactEdge, b : GraphcolorexactEdge) -> GraphcolorexactEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_edge_copy(s : GraphcolorexactEdge) -> GraphcolorexactEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_edge_fill(s : GraphcolorexactEdge, v : Double) -> GraphcolorexactEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_edge_min(s : GraphcolorexactEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_edge_max(s : GraphcolorexactEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_edge_to_string(s : GraphcolorexactEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_path_make(size : Int) -> GraphcolorexactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_path_len(s : GraphcolorexactPath) -> Int { s.size }

pub fn graph_color_exact_path_get(s : GraphcolorexactPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_path_set(s : GraphcolorexactPath, i : Int, v : Double) -> GraphcolorexactPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_path_sum(s : GraphcolorexactPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_path_mean(s : GraphcolorexactPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_path_scale(s : GraphcolorexactPath, f : Double) -> GraphcolorexactPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_path_add(a : GraphcolorexactPath, b : GraphcolorexactPath) -> GraphcolorexactPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_path_copy(s : GraphcolorexactPath) -> GraphcolorexactPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_path_fill(s : GraphcolorexactPath, v : Double) -> GraphcolorexactPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_path_min(s : GraphcolorexactPath) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_path_max(s : GraphcolorexactPath) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_path_to_string(s : GraphcolorexactPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_cluster_make(size : Int) -> GraphcolorexactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_cluster_len(s : GraphcolorexactCluster) -> Int { s.size }

pub fn graph_color_exact_cluster_get(s : GraphcolorexactCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_cluster_set(s : GraphcolorexactCluster, i : Int, v : Double) -> GraphcolorexactCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cluster_sum(s : GraphcolorexactCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_cluster_mean(s : GraphcolorexactCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_cluster_scale(s : GraphcolorexactCluster, f : Double) -> GraphcolorexactCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cluster_add(a : GraphcolorexactCluster, b : GraphcolorexactCluster) -> GraphcolorexactCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_cluster_copy(s : GraphcolorexactCluster) -> GraphcolorexactCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cluster_fill(s : GraphcolorexactCluster, v : Double) -> GraphcolorexactCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cluster_min(s : GraphcolorexactCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_cluster_max(s : GraphcolorexactCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_cluster_to_string(s : GraphcolorexactCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_model_make(size : Int) -> GraphcolorexactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_model_len(s : GraphcolorexactModel) -> Int { s.size }

pub fn graph_color_exact_model_get(s : GraphcolorexactModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_model_set(s : GraphcolorexactModel, i : Int, v : Double) -> GraphcolorexactModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_model_sum(s : GraphcolorexactModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_model_mean(s : GraphcolorexactModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_model_scale(s : GraphcolorexactModel, f : Double) -> GraphcolorexactModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_model_add(a : GraphcolorexactModel, b : GraphcolorexactModel) -> GraphcolorexactModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_model_copy(s : GraphcolorexactModel) -> GraphcolorexactModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_model_fill(s : GraphcolorexactModel, v : Double) -> GraphcolorexactModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_model_min(s : GraphcolorexactModel) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_model_max(s : GraphcolorexactModel) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_model_to_string(s : GraphcolorexactModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_layer_make(size : Int) -> GraphcolorexactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_layer_len(s : GraphcolorexactLayer) -> Int { s.size }

pub fn graph_color_exact_layer_get(s : GraphcolorexactLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_layer_set(s : GraphcolorexactLayer, i : Int, v : Double) -> GraphcolorexactLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_layer_sum(s : GraphcolorexactLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_layer_mean(s : GraphcolorexactLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_layer_scale(s : GraphcolorexactLayer, f : Double) -> GraphcolorexactLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_layer_add(a : GraphcolorexactLayer, b : GraphcolorexactLayer) -> GraphcolorexactLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_layer_copy(s : GraphcolorexactLayer) -> GraphcolorexactLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_layer_fill(s : GraphcolorexactLayer, v : Double) -> GraphcolorexactLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_layer_min(s : GraphcolorexactLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_layer_max(s : GraphcolorexactLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_layer_to_string(s : GraphcolorexactLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_buffer_make(size : Int) -> GraphcolorexactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_buffer_len(s : GraphcolorexactBuffer) -> Int { s.size }

pub fn graph_color_exact_buffer_get(s : GraphcolorexactBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_buffer_set(s : GraphcolorexactBuffer, i : Int, v : Double) -> GraphcolorexactBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_buffer_sum(s : GraphcolorexactBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_buffer_mean(s : GraphcolorexactBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_buffer_scale(s : GraphcolorexactBuffer, f : Double) -> GraphcolorexactBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_buffer_add(a : GraphcolorexactBuffer, b : GraphcolorexactBuffer) -> GraphcolorexactBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_buffer_copy(s : GraphcolorexactBuffer) -> GraphcolorexactBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_buffer_fill(s : GraphcolorexactBuffer, v : Double) -> GraphcolorexactBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_buffer_min(s : GraphcolorexactBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_buffer_max(s : GraphcolorexactBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_buffer_to_string(s : GraphcolorexactBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_cursor_make(size : Int) -> GraphcolorexactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_cursor_len(s : GraphcolorexactCursor) -> Int { s.size }

pub fn graph_color_exact_cursor_get(s : GraphcolorexactCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_cursor_set(s : GraphcolorexactCursor, i : Int, v : Double) -> GraphcolorexactCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cursor_sum(s : GraphcolorexactCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_cursor_mean(s : GraphcolorexactCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_cursor_scale(s : GraphcolorexactCursor, f : Double) -> GraphcolorexactCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cursor_add(a : GraphcolorexactCursor, b : GraphcolorexactCursor) -> GraphcolorexactCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_cursor_copy(s : GraphcolorexactCursor) -> GraphcolorexactCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cursor_fill(s : GraphcolorexactCursor, v : Double) -> GraphcolorexactCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_cursor_min(s : GraphcolorexactCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_cursor_max(s : GraphcolorexactCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_cursor_to_string(s : GraphcolorexactCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_view_make(size : Int) -> GraphcolorexactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_view_len(s : GraphcolorexactView) -> Int { s.size }

pub fn graph_color_exact_view_get(s : GraphcolorexactView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_view_set(s : GraphcolorexactView, i : Int, v : Double) -> GraphcolorexactView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_view_sum(s : GraphcolorexactView) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_view_mean(s : GraphcolorexactView) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_view_scale(s : GraphcolorexactView, f : Double) -> GraphcolorexactView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_view_add(a : GraphcolorexactView, b : GraphcolorexactView) -> GraphcolorexactView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_view_copy(s : GraphcolorexactView) -> GraphcolorexactView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_view_fill(s : GraphcolorexactView, v : Double) -> GraphcolorexactView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_view_min(s : GraphcolorexactView) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_view_max(s : GraphcolorexactView) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_view_to_string(s : GraphcolorexactView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_range_make(size : Int) -> GraphcolorexactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_range_len(s : GraphcolorexactRange) -> Int { s.size }

pub fn graph_color_exact_range_get(s : GraphcolorexactRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_range_set(s : GraphcolorexactRange, i : Int, v : Double) -> GraphcolorexactRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_range_sum(s : GraphcolorexactRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_range_mean(s : GraphcolorexactRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_range_scale(s : GraphcolorexactRange, f : Double) -> GraphcolorexactRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_range_add(a : GraphcolorexactRange, b : GraphcolorexactRange) -> GraphcolorexactRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_range_copy(s : GraphcolorexactRange) -> GraphcolorexactRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_range_fill(s : GraphcolorexactRange, v : Double) -> GraphcolorexactRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_range_min(s : GraphcolorexactRange) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_range_max(s : GraphcolorexactRange) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_range_to_string(s : GraphcolorexactRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_slice_make(size : Int) -> GraphcolorexactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_slice_len(s : GraphcolorexactSlice) -> Int { s.size }

pub fn graph_color_exact_slice_get(s : GraphcolorexactSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_slice_set(s : GraphcolorexactSlice, i : Int, v : Double) -> GraphcolorexactSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_exact_slice_sum(s : GraphcolorexactSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_exact_slice_mean(s : GraphcolorexactSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_exact_slice_scale(s : GraphcolorexactSlice, f : Double) -> GraphcolorexactSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_slice_add(a : GraphcolorexactSlice, b : GraphcolorexactSlice) -> GraphcolorexactSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_exact_slice_copy(s : GraphcolorexactSlice) -> GraphcolorexactSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_slice_fill(s : GraphcolorexactSlice, v : Double) -> GraphcolorexactSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_exact_slice_min(s : GraphcolorexactSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_exact_slice_max(s : GraphcolorexactSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_exact_slice_to_string(s : GraphcolorexactSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

