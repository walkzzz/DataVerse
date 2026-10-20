///===
/// extcore/opt_meta_aco

pub(all) struct OptmetaacoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_aco_make_point(x : Double, y : Double) -> OptmetaacoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_aco_make_point3(x : Double, y : Double, z : Double) -> OptmetaacoPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetaacoPoint::x(self : OptmetaacoPoint) -> Double { self.x }

pub fn OptmetaacoPoint::y(self : OptmetaacoPoint) -> Double { self.y }

pub fn OptmetaacoPoint::z(self : OptmetaacoPoint) -> Double { self.z }

pub fn OptmetaacoPoint::label(self : OptmetaacoPoint) -> Int { self.label }

pub fn OptmetaacoPoint::dist(self : OptmetaacoPoint, other : OptmetaacoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetaacoPoint::add(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetaacoPoint::sub(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetaacoPoint::scale(self : OptmetaacoPoint, s : Double) -> OptmetaacoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetaacoPoint::dot(self : OptmetaacoPoint, other : OptmetaacoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetaacoPoint::cross(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetaacoPoint::norm(self : OptmetaacoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetaacoPoint::normalize(self : OptmetaacoPoint) -> OptmetaacoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaacoPoint::negate(self : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetaacoPoint::mid(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetaacoPoint::lerp(self : OptmetaacoPoint, other : OptmetaacoPoint, t : Double) -> OptmetaacoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetaacoPoint::to_string(self : OptmetaacoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetaacoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_aco_make_series(vals : Array[Double], name : String) -> OptmetaacoSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetaacoSeries::len(self : OptmetaacoSeries) -> Int { self.vals.length() }

pub fn OptmetaacoSeries::sum(self : OptmetaacoSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetaacoSeries::mean(self : OptmetaacoSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetaacoSeries::min(self : OptmetaacoSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetaacoSeries::max(self : OptmetaacoSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetaacoSeries::range(self : OptmetaacoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetaacoSeries::variance(self : OptmetaacoSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetaacoSeries::std(self : OptmetaacoSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetaacoSeries::median(self : OptmetaacoSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetaacoSeries::scale(self : OptmetaacoSeries, f : Double) -> OptmetaacoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetaacoSeries::add(self : OptmetaacoSeries, other : OptmetaacoSeries) -> OptmetaacoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetaacoSeries::sub(self : OptmetaacoSeries, other : OptmetaacoSeries) -> OptmetaacoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetaacoSeries::normalize(self : OptmetaacoSeries) -> OptmetaacoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetaacoSeries::cumsum(self : OptmetaacoSeries) -> OptmetaacoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetaacoSeries::to_string(self : OptmetaacoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaacoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_aco_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetaacoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_aco_matrix_identity(n : Int) -> OptmetaacoMatrix {
  let m = opt_meta_aco_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetaacoMatrix::get(self : OptmetaacoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetaacoMatrix::transpose(self : OptmetaacoMatrix) -> OptmetaacoMatrix {
  let result = opt_meta_aco_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetaacoMatrix::add(self : OptmetaacoMatrix, other : OptmetaacoMatrix) -> OptmetaacoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_aco_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetaacoMatrix::scale(self : OptmetaacoMatrix, s : Double) -> OptmetaacoMatrix {
  let result = opt_meta_aco_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetaacoMatrix::multiply(self : OptmetaacoMatrix, other : OptmetaacoMatrix) -> OptmetaacoMatrix {
  if self.cols != other.rows { return opt_meta_aco_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_aco_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetaacoMatrix::trace(self : OptmetaacoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetaacoMatrix::det(self : OptmetaacoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetaacoMatrix::norm(self : OptmetaacoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetaacoMatrix::to_string(self : OptmetaacoMatrix) -> String {
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

pub(all) struct OptmetaacoVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_aco_make_vector(comps : Array[Double]) -> OptmetaacoVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_aco_vector_zero(dim : Int) -> OptmetaacoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetaacoVector::add(self : OptmetaacoVector, other : OptmetaacoVector) -> OptmetaacoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaacoVector::sub(self : OptmetaacoVector, other : OptmetaacoVector) -> OptmetaacoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaacoVector::scale(self : OptmetaacoVector, s : Double) -> OptmetaacoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetaacoVector::dot(self : OptmetaacoVector, other : OptmetaacoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetaacoVector::norm(self : OptmetaacoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetaacoVector::normalize(self : OptmetaacoVector) -> OptmetaacoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaacoVector::dist(self : OptmetaacoVector, other : OptmetaacoVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetaacoVector::to_string(self : OptmetaacoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_aco_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_aco_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_aco_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_aco_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_aco_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_aco_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_aco_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_aco_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_aco_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_aco_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_aco_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_aco_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_aco_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_aco_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_aco_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_aco_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_aco_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_aco_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_aco_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_aco_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_aco_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_aco_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_aco_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_aco_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_aco_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_aco_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_aco_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_aco_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_aco_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetaacoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_frame_make(size : Int) -> OptmetaacoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_frame_len(s : OptmetaacoFrame) -> Int { s.size }

pub fn opt_meta_aco_frame_get(s : OptmetaacoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_frame_set(s : OptmetaacoFrame, i : Int, v : Double) -> OptmetaacoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_frame_sum(s : OptmetaacoFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_frame_mean(s : OptmetaacoFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_frame_scale(s : OptmetaacoFrame, f : Double) -> OptmetaacoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_frame_add(a : OptmetaacoFrame, b : OptmetaacoFrame) -> OptmetaacoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_frame_copy(s : OptmetaacoFrame) -> OptmetaacoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_frame_fill(s : OptmetaacoFrame, v : Double) -> OptmetaacoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_frame_min(s : OptmetaacoFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_frame_max(s : OptmetaacoFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_frame_to_string(s : OptmetaacoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_table_make(size : Int) -> OptmetaacoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_table_len(s : OptmetaacoTable) -> Int { s.size }

pub fn opt_meta_aco_table_get(s : OptmetaacoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_table_set(s : OptmetaacoTable, i : Int, v : Double) -> OptmetaacoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_table_sum(s : OptmetaacoTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_table_mean(s : OptmetaacoTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_table_scale(s : OptmetaacoTable, f : Double) -> OptmetaacoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_table_add(a : OptmetaacoTable, b : OptmetaacoTable) -> OptmetaacoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_table_copy(s : OptmetaacoTable) -> OptmetaacoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_table_fill(s : OptmetaacoTable, v : Double) -> OptmetaacoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_table_min(s : OptmetaacoTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_table_max(s : OptmetaacoTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_table_to_string(s : OptmetaacoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_graphn_make(size : Int) -> OptmetaacoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_graphn_len(s : OptmetaacoGraphN) -> Int { s.size }

pub fn opt_meta_aco_graphn_get(s : OptmetaacoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_graphn_set(s : OptmetaacoGraphN, i : Int, v : Double) -> OptmetaacoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_graphn_sum(s : OptmetaacoGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_graphn_mean(s : OptmetaacoGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_graphn_scale(s : OptmetaacoGraphN, f : Double) -> OptmetaacoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_graphn_add(a : OptmetaacoGraphN, b : OptmetaacoGraphN) -> OptmetaacoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_graphn_copy(s : OptmetaacoGraphN) -> OptmetaacoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_graphn_fill(s : OptmetaacoGraphN, v : Double) -> OptmetaacoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_graphn_min(s : OptmetaacoGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_graphn_max(s : OptmetaacoGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_graphn_to_string(s : OptmetaacoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_node_make(size : Int) -> OptmetaacoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_node_len(s : OptmetaacoNode) -> Int { s.size }

pub fn opt_meta_aco_node_get(s : OptmetaacoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_node_set(s : OptmetaacoNode, i : Int, v : Double) -> OptmetaacoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_node_sum(s : OptmetaacoNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_node_mean(s : OptmetaacoNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_node_scale(s : OptmetaacoNode, f : Double) -> OptmetaacoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_node_add(a : OptmetaacoNode, b : OptmetaacoNode) -> OptmetaacoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_node_copy(s : OptmetaacoNode) -> OptmetaacoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_node_fill(s : OptmetaacoNode, v : Double) -> OptmetaacoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_node_min(s : OptmetaacoNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_node_max(s : OptmetaacoNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_node_to_string(s : OptmetaacoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_edge_make(size : Int) -> OptmetaacoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_edge_len(s : OptmetaacoEdge) -> Int { s.size }

pub fn opt_meta_aco_edge_get(s : OptmetaacoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_edge_set(s : OptmetaacoEdge, i : Int, v : Double) -> OptmetaacoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_edge_sum(s : OptmetaacoEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_edge_mean(s : OptmetaacoEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_edge_scale(s : OptmetaacoEdge, f : Double) -> OptmetaacoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_edge_add(a : OptmetaacoEdge, b : OptmetaacoEdge) -> OptmetaacoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_edge_copy(s : OptmetaacoEdge) -> OptmetaacoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_edge_fill(s : OptmetaacoEdge, v : Double) -> OptmetaacoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_edge_min(s : OptmetaacoEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_edge_max(s : OptmetaacoEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_edge_to_string(s : OptmetaacoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_path_make(size : Int) -> OptmetaacoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_path_len(s : OptmetaacoPath) -> Int { s.size }

pub fn opt_meta_aco_path_get(s : OptmetaacoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_path_set(s : OptmetaacoPath, i : Int, v : Double) -> OptmetaacoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_path_sum(s : OptmetaacoPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_path_mean(s : OptmetaacoPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_path_scale(s : OptmetaacoPath, f : Double) -> OptmetaacoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_path_add(a : OptmetaacoPath, b : OptmetaacoPath) -> OptmetaacoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_path_copy(s : OptmetaacoPath) -> OptmetaacoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_path_fill(s : OptmetaacoPath, v : Double) -> OptmetaacoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_path_min(s : OptmetaacoPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_path_max(s : OptmetaacoPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_path_to_string(s : OptmetaacoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_cluster_make(size : Int) -> OptmetaacoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_cluster_len(s : OptmetaacoCluster) -> Int { s.size }

pub fn opt_meta_aco_cluster_get(s : OptmetaacoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_cluster_set(s : OptmetaacoCluster, i : Int, v : Double) -> OptmetaacoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cluster_sum(s : OptmetaacoCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_cluster_mean(s : OptmetaacoCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_cluster_scale(s : OptmetaacoCluster, f : Double) -> OptmetaacoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cluster_add(a : OptmetaacoCluster, b : OptmetaacoCluster) -> OptmetaacoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_cluster_copy(s : OptmetaacoCluster) -> OptmetaacoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cluster_fill(s : OptmetaacoCluster, v : Double) -> OptmetaacoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cluster_min(s : OptmetaacoCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_cluster_max(s : OptmetaacoCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_cluster_to_string(s : OptmetaacoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_model_make(size : Int) -> OptmetaacoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_model_len(s : OptmetaacoModel) -> Int { s.size }

pub fn opt_meta_aco_model_get(s : OptmetaacoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_model_set(s : OptmetaacoModel, i : Int, v : Double) -> OptmetaacoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_model_sum(s : OptmetaacoModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_model_mean(s : OptmetaacoModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_model_scale(s : OptmetaacoModel, f : Double) -> OptmetaacoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_model_add(a : OptmetaacoModel, b : OptmetaacoModel) -> OptmetaacoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_model_copy(s : OptmetaacoModel) -> OptmetaacoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_model_fill(s : OptmetaacoModel, v : Double) -> OptmetaacoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_model_min(s : OptmetaacoModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_model_max(s : OptmetaacoModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_model_to_string(s : OptmetaacoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_layer_make(size : Int) -> OptmetaacoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_layer_len(s : OptmetaacoLayer) -> Int { s.size }

pub fn opt_meta_aco_layer_get(s : OptmetaacoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_layer_set(s : OptmetaacoLayer, i : Int, v : Double) -> OptmetaacoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_layer_sum(s : OptmetaacoLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_layer_mean(s : OptmetaacoLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_layer_scale(s : OptmetaacoLayer, f : Double) -> OptmetaacoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_layer_add(a : OptmetaacoLayer, b : OptmetaacoLayer) -> OptmetaacoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_layer_copy(s : OptmetaacoLayer) -> OptmetaacoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_layer_fill(s : OptmetaacoLayer, v : Double) -> OptmetaacoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_layer_min(s : OptmetaacoLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_layer_max(s : OptmetaacoLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_layer_to_string(s : OptmetaacoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_buffer_make(size : Int) -> OptmetaacoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_buffer_len(s : OptmetaacoBuffer) -> Int { s.size }

pub fn opt_meta_aco_buffer_get(s : OptmetaacoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_buffer_set(s : OptmetaacoBuffer, i : Int, v : Double) -> OptmetaacoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_buffer_sum(s : OptmetaacoBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_buffer_mean(s : OptmetaacoBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_buffer_scale(s : OptmetaacoBuffer, f : Double) -> OptmetaacoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_buffer_add(a : OptmetaacoBuffer, b : OptmetaacoBuffer) -> OptmetaacoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_buffer_copy(s : OptmetaacoBuffer) -> OptmetaacoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_buffer_fill(s : OptmetaacoBuffer, v : Double) -> OptmetaacoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_buffer_min(s : OptmetaacoBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_buffer_max(s : OptmetaacoBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_buffer_to_string(s : OptmetaacoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_cursor_make(size : Int) -> OptmetaacoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_cursor_len(s : OptmetaacoCursor) -> Int { s.size }

pub fn opt_meta_aco_cursor_get(s : OptmetaacoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_cursor_set(s : OptmetaacoCursor, i : Int, v : Double) -> OptmetaacoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cursor_sum(s : OptmetaacoCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_cursor_mean(s : OptmetaacoCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_cursor_scale(s : OptmetaacoCursor, f : Double) -> OptmetaacoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cursor_add(a : OptmetaacoCursor, b : OptmetaacoCursor) -> OptmetaacoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_cursor_copy(s : OptmetaacoCursor) -> OptmetaacoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cursor_fill(s : OptmetaacoCursor, v : Double) -> OptmetaacoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_cursor_min(s : OptmetaacoCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_cursor_max(s : OptmetaacoCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_cursor_to_string(s : OptmetaacoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_view_make(size : Int) -> OptmetaacoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_view_len(s : OptmetaacoView) -> Int { s.size }

pub fn opt_meta_aco_view_get(s : OptmetaacoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_view_set(s : OptmetaacoView, i : Int, v : Double) -> OptmetaacoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_view_sum(s : OptmetaacoView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_view_mean(s : OptmetaacoView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_view_scale(s : OptmetaacoView, f : Double) -> OptmetaacoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_view_add(a : OptmetaacoView, b : OptmetaacoView) -> OptmetaacoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_view_copy(s : OptmetaacoView) -> OptmetaacoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_view_fill(s : OptmetaacoView, v : Double) -> OptmetaacoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_view_min(s : OptmetaacoView) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_view_max(s : OptmetaacoView) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_view_to_string(s : OptmetaacoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_range_make(size : Int) -> OptmetaacoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_range_len(s : OptmetaacoRange) -> Int { s.size }

pub fn opt_meta_aco_range_get(s : OptmetaacoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_range_set(s : OptmetaacoRange, i : Int, v : Double) -> OptmetaacoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_range_sum(s : OptmetaacoRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_range_mean(s : OptmetaacoRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_range_scale(s : OptmetaacoRange, f : Double) -> OptmetaacoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_range_add(a : OptmetaacoRange, b : OptmetaacoRange) -> OptmetaacoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_range_copy(s : OptmetaacoRange) -> OptmetaacoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_range_fill(s : OptmetaacoRange, v : Double) -> OptmetaacoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_range_min(s : OptmetaacoRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_range_max(s : OptmetaacoRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_range_to_string(s : OptmetaacoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_slice_make(size : Int) -> OptmetaacoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_slice_len(s : OptmetaacoSlice) -> Int { s.size }

pub fn opt_meta_aco_slice_get(s : OptmetaacoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_slice_set(s : OptmetaacoSlice, i : Int, v : Double) -> OptmetaacoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_slice_sum(s : OptmetaacoSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_aco_slice_mean(s : OptmetaacoSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_aco_slice_scale(s : OptmetaacoSlice, f : Double) -> OptmetaacoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_slice_add(a : OptmetaacoSlice, b : OptmetaacoSlice) -> OptmetaacoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_aco_slice_copy(s : OptmetaacoSlice) -> OptmetaacoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_slice_fill(s : OptmetaacoSlice, v : Double) -> OptmetaacoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_aco_slice_min(s : OptmetaacoSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_aco_slice_max(s : OptmetaacoSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_aco_slice_to_string(s : OptmetaacoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

