///===
/// extcore/math_tensor_calc

pub(all) struct MathtensorcalcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_tensor_calc_make_point(x : Double, y : Double) -> MathtensorcalcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_tensor_calc_make_point3(x : Double, y : Double, z : Double) -> MathtensorcalcPoint {
  { x, y, z, label: 0 }
}

pub fn MathtensorcalcPoint::x(self : MathtensorcalcPoint) -> Double { self.x }

pub fn MathtensorcalcPoint::y(self : MathtensorcalcPoint) -> Double { self.y }

pub fn MathtensorcalcPoint::z(self : MathtensorcalcPoint) -> Double { self.z }

pub fn MathtensorcalcPoint::label(self : MathtensorcalcPoint) -> Int { self.label }

pub fn MathtensorcalcPoint::dist(self : MathtensorcalcPoint, other : MathtensorcalcPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathtensorcalcPoint::add(self : MathtensorcalcPoint, other : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathtensorcalcPoint::sub(self : MathtensorcalcPoint, other : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathtensorcalcPoint::scale(self : MathtensorcalcPoint, s : Double) -> MathtensorcalcPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathtensorcalcPoint::dot(self : MathtensorcalcPoint, other : MathtensorcalcPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathtensorcalcPoint::cross(self : MathtensorcalcPoint, other : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathtensorcalcPoint::norm(self : MathtensorcalcPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathtensorcalcPoint::normalize(self : MathtensorcalcPoint) -> MathtensorcalcPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathtensorcalcPoint::negate(self : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathtensorcalcPoint::mid(self : MathtensorcalcPoint, other : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathtensorcalcPoint::lerp(self : MathtensorcalcPoint, other : MathtensorcalcPoint, t : Double) -> MathtensorcalcPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathtensorcalcPoint::to_string(self : MathtensorcalcPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathtensorcalcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_tensor_calc_make_series(vals : Array[Double], name : String) -> MathtensorcalcSeries {
  { vals, name, meta: 0 }
}

pub fn MathtensorcalcSeries::len(self : MathtensorcalcSeries) -> Int { self.vals.length() }

pub fn MathtensorcalcSeries::sum(self : MathtensorcalcSeries) -> Double { @_common.sum(self.vals) }

pub fn MathtensorcalcSeries::mean(self : MathtensorcalcSeries) -> Double { @_common.mean(self.vals) }

pub fn MathtensorcalcSeries::min(self : MathtensorcalcSeries) -> Double { @_common.min(self.vals) }

pub fn MathtensorcalcSeries::max(self : MathtensorcalcSeries) -> Double { @_common.max(self.vals) }

pub fn MathtensorcalcSeries::range(self : MathtensorcalcSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathtensorcalcSeries::variance(self : MathtensorcalcSeries) -> Double { @_common.variance(self.vals) }

pub fn MathtensorcalcSeries::std(self : MathtensorcalcSeries) -> Double { @_common.std(self.vals) }

pub fn MathtensorcalcSeries::median(self : MathtensorcalcSeries) -> Double { @_common.median(self.vals) }

pub fn MathtensorcalcSeries::scale(self : MathtensorcalcSeries, f : Double) -> MathtensorcalcSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathtensorcalcSeries::add(self : MathtensorcalcSeries, other : MathtensorcalcSeries) -> MathtensorcalcSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathtensorcalcSeries::sub(self : MathtensorcalcSeries, other : MathtensorcalcSeries) -> MathtensorcalcSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathtensorcalcSeries::normalize(self : MathtensorcalcSeries) -> MathtensorcalcSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathtensorcalcSeries::cumsum(self : MathtensorcalcSeries) -> MathtensorcalcSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathtensorcalcSeries::to_string(self : MathtensorcalcSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathtensorcalcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_tensor_calc_make_matrix(rows : Int, cols : Int, val : Double) -> MathtensorcalcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_tensor_calc_matrix_identity(n : Int) -> MathtensorcalcMatrix {
  let m = math_tensor_calc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathtensorcalcMatrix::get(self : MathtensorcalcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathtensorcalcMatrix::transpose(self : MathtensorcalcMatrix) -> MathtensorcalcMatrix {
  let result = math_tensor_calc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathtensorcalcMatrix::add(self : MathtensorcalcMatrix, other : MathtensorcalcMatrix) -> MathtensorcalcMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_tensor_calc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathtensorcalcMatrix::scale(self : MathtensorcalcMatrix, s : Double) -> MathtensorcalcMatrix {
  let result = math_tensor_calc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathtensorcalcMatrix::multiply(self : MathtensorcalcMatrix, other : MathtensorcalcMatrix) -> MathtensorcalcMatrix {
  if self.cols != other.rows { return math_tensor_calc_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_tensor_calc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathtensorcalcMatrix::trace(self : MathtensorcalcMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathtensorcalcMatrix::det(self : MathtensorcalcMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathtensorcalcMatrix::norm(self : MathtensorcalcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathtensorcalcMatrix::to_string(self : MathtensorcalcMatrix) -> String {
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

pub(all) struct MathtensorcalcVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_tensor_calc_make_vector(comps : Array[Double]) -> MathtensorcalcVector {
  { comps, dim: comps.length() }
}

pub fn math_tensor_calc_vector_zero(dim : Int) -> MathtensorcalcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathtensorcalcVector::add(self : MathtensorcalcVector, other : MathtensorcalcVector) -> MathtensorcalcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathtensorcalcVector::sub(self : MathtensorcalcVector, other : MathtensorcalcVector) -> MathtensorcalcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathtensorcalcVector::scale(self : MathtensorcalcVector, s : Double) -> MathtensorcalcVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathtensorcalcVector::dot(self : MathtensorcalcVector, other : MathtensorcalcVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathtensorcalcVector::norm(self : MathtensorcalcVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathtensorcalcVector::normalize(self : MathtensorcalcVector) -> MathtensorcalcVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathtensorcalcVector::dist(self : MathtensorcalcVector, other : MathtensorcalcVector) -> Double {
  self.sub(other).norm()
}

pub fn MathtensorcalcVector::to_string(self : MathtensorcalcVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_tensor_calc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_tensor_calc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_tensor_calc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_tensor_calc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_tensor_calc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_tensor_calc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_tensor_calc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_tensor_calc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_tensor_calc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_tensor_calc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_tensor_calc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_tensor_calc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_tensor_calc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_tensor_calc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_tensor_calc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_tensor_calc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_tensor_calc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_tensor_calc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_tensor_calc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_tensor_calc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_tensor_calc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_tensor_calc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_tensor_calc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_tensor_calc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_tensor_calc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_tensor_calc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_tensor_calc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_tensor_calc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_tensor_calc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathtensorcalcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_frame_make(size : Int) -> MathtensorcalcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_frame_len(s : MathtensorcalcFrame) -> Int { s.size }

pub fn math_tensor_calc_frame_get(s : MathtensorcalcFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_frame_set(s : MathtensorcalcFrame, i : Int, v : Double) -> MathtensorcalcFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_frame_sum(s : MathtensorcalcFrame) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_frame_mean(s : MathtensorcalcFrame) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_frame_scale(s : MathtensorcalcFrame, f : Double) -> MathtensorcalcFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_frame_add(a : MathtensorcalcFrame, b : MathtensorcalcFrame) -> MathtensorcalcFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_frame_copy(s : MathtensorcalcFrame) -> MathtensorcalcFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_frame_fill(s : MathtensorcalcFrame, v : Double) -> MathtensorcalcFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_frame_min(s : MathtensorcalcFrame) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_frame_max(s : MathtensorcalcFrame) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_frame_to_string(s : MathtensorcalcFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_table_make(size : Int) -> MathtensorcalcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_table_len(s : MathtensorcalcTable) -> Int { s.size }

pub fn math_tensor_calc_table_get(s : MathtensorcalcTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_table_set(s : MathtensorcalcTable, i : Int, v : Double) -> MathtensorcalcTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_table_sum(s : MathtensorcalcTable) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_table_mean(s : MathtensorcalcTable) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_table_scale(s : MathtensorcalcTable, f : Double) -> MathtensorcalcTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_table_add(a : MathtensorcalcTable, b : MathtensorcalcTable) -> MathtensorcalcTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_table_copy(s : MathtensorcalcTable) -> MathtensorcalcTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_table_fill(s : MathtensorcalcTable, v : Double) -> MathtensorcalcTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_table_min(s : MathtensorcalcTable) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_table_max(s : MathtensorcalcTable) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_table_to_string(s : MathtensorcalcTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_graphn_make(size : Int) -> MathtensorcalcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_graphn_len(s : MathtensorcalcGraphN) -> Int { s.size }

pub fn math_tensor_calc_graphn_get(s : MathtensorcalcGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_graphn_set(s : MathtensorcalcGraphN, i : Int, v : Double) -> MathtensorcalcGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_graphn_sum(s : MathtensorcalcGraphN) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_graphn_mean(s : MathtensorcalcGraphN) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_graphn_scale(s : MathtensorcalcGraphN, f : Double) -> MathtensorcalcGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_graphn_add(a : MathtensorcalcGraphN, b : MathtensorcalcGraphN) -> MathtensorcalcGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_graphn_copy(s : MathtensorcalcGraphN) -> MathtensorcalcGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_graphn_fill(s : MathtensorcalcGraphN, v : Double) -> MathtensorcalcGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_graphn_min(s : MathtensorcalcGraphN) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_graphn_max(s : MathtensorcalcGraphN) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_graphn_to_string(s : MathtensorcalcGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_node_make(size : Int) -> MathtensorcalcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_node_len(s : MathtensorcalcNode) -> Int { s.size }

pub fn math_tensor_calc_node_get(s : MathtensorcalcNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_node_set(s : MathtensorcalcNode, i : Int, v : Double) -> MathtensorcalcNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_node_sum(s : MathtensorcalcNode) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_node_mean(s : MathtensorcalcNode) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_node_scale(s : MathtensorcalcNode, f : Double) -> MathtensorcalcNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_node_add(a : MathtensorcalcNode, b : MathtensorcalcNode) -> MathtensorcalcNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_node_copy(s : MathtensorcalcNode) -> MathtensorcalcNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_node_fill(s : MathtensorcalcNode, v : Double) -> MathtensorcalcNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_node_min(s : MathtensorcalcNode) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_node_max(s : MathtensorcalcNode) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_node_to_string(s : MathtensorcalcNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_edge_make(size : Int) -> MathtensorcalcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_edge_len(s : MathtensorcalcEdge) -> Int { s.size }

pub fn math_tensor_calc_edge_get(s : MathtensorcalcEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_edge_set(s : MathtensorcalcEdge, i : Int, v : Double) -> MathtensorcalcEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_edge_sum(s : MathtensorcalcEdge) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_edge_mean(s : MathtensorcalcEdge) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_edge_scale(s : MathtensorcalcEdge, f : Double) -> MathtensorcalcEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_edge_add(a : MathtensorcalcEdge, b : MathtensorcalcEdge) -> MathtensorcalcEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_edge_copy(s : MathtensorcalcEdge) -> MathtensorcalcEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_edge_fill(s : MathtensorcalcEdge, v : Double) -> MathtensorcalcEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_edge_min(s : MathtensorcalcEdge) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_edge_max(s : MathtensorcalcEdge) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_edge_to_string(s : MathtensorcalcEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_path_make(size : Int) -> MathtensorcalcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_path_len(s : MathtensorcalcPath) -> Int { s.size }

pub fn math_tensor_calc_path_get(s : MathtensorcalcPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_path_set(s : MathtensorcalcPath, i : Int, v : Double) -> MathtensorcalcPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_path_sum(s : MathtensorcalcPath) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_path_mean(s : MathtensorcalcPath) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_path_scale(s : MathtensorcalcPath, f : Double) -> MathtensorcalcPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_path_add(a : MathtensorcalcPath, b : MathtensorcalcPath) -> MathtensorcalcPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_path_copy(s : MathtensorcalcPath) -> MathtensorcalcPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_path_fill(s : MathtensorcalcPath, v : Double) -> MathtensorcalcPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_path_min(s : MathtensorcalcPath) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_path_max(s : MathtensorcalcPath) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_path_to_string(s : MathtensorcalcPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_cluster_make(size : Int) -> MathtensorcalcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_cluster_len(s : MathtensorcalcCluster) -> Int { s.size }

pub fn math_tensor_calc_cluster_get(s : MathtensorcalcCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_cluster_set(s : MathtensorcalcCluster, i : Int, v : Double) -> MathtensorcalcCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cluster_sum(s : MathtensorcalcCluster) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_cluster_mean(s : MathtensorcalcCluster) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_cluster_scale(s : MathtensorcalcCluster, f : Double) -> MathtensorcalcCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cluster_add(a : MathtensorcalcCluster, b : MathtensorcalcCluster) -> MathtensorcalcCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_cluster_copy(s : MathtensorcalcCluster) -> MathtensorcalcCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cluster_fill(s : MathtensorcalcCluster, v : Double) -> MathtensorcalcCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cluster_min(s : MathtensorcalcCluster) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_cluster_max(s : MathtensorcalcCluster) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_cluster_to_string(s : MathtensorcalcCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_model_make(size : Int) -> MathtensorcalcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_model_len(s : MathtensorcalcModel) -> Int { s.size }

pub fn math_tensor_calc_model_get(s : MathtensorcalcModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_model_set(s : MathtensorcalcModel, i : Int, v : Double) -> MathtensorcalcModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_model_sum(s : MathtensorcalcModel) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_model_mean(s : MathtensorcalcModel) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_model_scale(s : MathtensorcalcModel, f : Double) -> MathtensorcalcModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_model_add(a : MathtensorcalcModel, b : MathtensorcalcModel) -> MathtensorcalcModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_model_copy(s : MathtensorcalcModel) -> MathtensorcalcModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_model_fill(s : MathtensorcalcModel, v : Double) -> MathtensorcalcModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_model_min(s : MathtensorcalcModel) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_model_max(s : MathtensorcalcModel) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_model_to_string(s : MathtensorcalcModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_layer_make(size : Int) -> MathtensorcalcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_layer_len(s : MathtensorcalcLayer) -> Int { s.size }

pub fn math_tensor_calc_layer_get(s : MathtensorcalcLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_layer_set(s : MathtensorcalcLayer, i : Int, v : Double) -> MathtensorcalcLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_layer_sum(s : MathtensorcalcLayer) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_layer_mean(s : MathtensorcalcLayer) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_layer_scale(s : MathtensorcalcLayer, f : Double) -> MathtensorcalcLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_layer_add(a : MathtensorcalcLayer, b : MathtensorcalcLayer) -> MathtensorcalcLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_layer_copy(s : MathtensorcalcLayer) -> MathtensorcalcLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_layer_fill(s : MathtensorcalcLayer, v : Double) -> MathtensorcalcLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_layer_min(s : MathtensorcalcLayer) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_layer_max(s : MathtensorcalcLayer) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_layer_to_string(s : MathtensorcalcLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_buffer_make(size : Int) -> MathtensorcalcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_buffer_len(s : MathtensorcalcBuffer) -> Int { s.size }

pub fn math_tensor_calc_buffer_get(s : MathtensorcalcBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_buffer_set(s : MathtensorcalcBuffer, i : Int, v : Double) -> MathtensorcalcBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_buffer_sum(s : MathtensorcalcBuffer) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_buffer_mean(s : MathtensorcalcBuffer) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_buffer_scale(s : MathtensorcalcBuffer, f : Double) -> MathtensorcalcBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_buffer_add(a : MathtensorcalcBuffer, b : MathtensorcalcBuffer) -> MathtensorcalcBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_buffer_copy(s : MathtensorcalcBuffer) -> MathtensorcalcBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_buffer_fill(s : MathtensorcalcBuffer, v : Double) -> MathtensorcalcBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_buffer_min(s : MathtensorcalcBuffer) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_buffer_max(s : MathtensorcalcBuffer) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_buffer_to_string(s : MathtensorcalcBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_cursor_make(size : Int) -> MathtensorcalcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_cursor_len(s : MathtensorcalcCursor) -> Int { s.size }

pub fn math_tensor_calc_cursor_get(s : MathtensorcalcCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_cursor_set(s : MathtensorcalcCursor, i : Int, v : Double) -> MathtensorcalcCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cursor_sum(s : MathtensorcalcCursor) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_cursor_mean(s : MathtensorcalcCursor) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_cursor_scale(s : MathtensorcalcCursor, f : Double) -> MathtensorcalcCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cursor_add(a : MathtensorcalcCursor, b : MathtensorcalcCursor) -> MathtensorcalcCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_cursor_copy(s : MathtensorcalcCursor) -> MathtensorcalcCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cursor_fill(s : MathtensorcalcCursor, v : Double) -> MathtensorcalcCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cursor_min(s : MathtensorcalcCursor) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_cursor_max(s : MathtensorcalcCursor) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_cursor_to_string(s : MathtensorcalcCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_view_make(size : Int) -> MathtensorcalcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_view_len(s : MathtensorcalcView) -> Int { s.size }

pub fn math_tensor_calc_view_get(s : MathtensorcalcView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_view_set(s : MathtensorcalcView, i : Int, v : Double) -> MathtensorcalcView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_view_sum(s : MathtensorcalcView) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_view_mean(s : MathtensorcalcView) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_view_scale(s : MathtensorcalcView, f : Double) -> MathtensorcalcView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_view_add(a : MathtensorcalcView, b : MathtensorcalcView) -> MathtensorcalcView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_view_copy(s : MathtensorcalcView) -> MathtensorcalcView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_view_fill(s : MathtensorcalcView, v : Double) -> MathtensorcalcView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_view_min(s : MathtensorcalcView) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_view_max(s : MathtensorcalcView) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_view_to_string(s : MathtensorcalcView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_range_make(size : Int) -> MathtensorcalcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_range_len(s : MathtensorcalcRange) -> Int { s.size }

pub fn math_tensor_calc_range_get(s : MathtensorcalcRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_range_set(s : MathtensorcalcRange, i : Int, v : Double) -> MathtensorcalcRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_range_sum(s : MathtensorcalcRange) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_range_mean(s : MathtensorcalcRange) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_range_scale(s : MathtensorcalcRange, f : Double) -> MathtensorcalcRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_range_add(a : MathtensorcalcRange, b : MathtensorcalcRange) -> MathtensorcalcRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_range_copy(s : MathtensorcalcRange) -> MathtensorcalcRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_range_fill(s : MathtensorcalcRange, v : Double) -> MathtensorcalcRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_range_min(s : MathtensorcalcRange) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_range_max(s : MathtensorcalcRange) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_range_to_string(s : MathtensorcalcRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_slice_make(size : Int) -> MathtensorcalcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_slice_len(s : MathtensorcalcSlice) -> Int { s.size }

pub fn math_tensor_calc_slice_get(s : MathtensorcalcSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_slice_set(s : MathtensorcalcSlice, i : Int, v : Double) -> MathtensorcalcSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_slice_sum(s : MathtensorcalcSlice) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_slice_mean(s : MathtensorcalcSlice) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_slice_scale(s : MathtensorcalcSlice, f : Double) -> MathtensorcalcSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_slice_add(a : MathtensorcalcSlice, b : MathtensorcalcSlice) -> MathtensorcalcSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_slice_copy(s : MathtensorcalcSlice) -> MathtensorcalcSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_slice_fill(s : MathtensorcalcSlice, v : Double) -> MathtensorcalcSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_slice_min(s : MathtensorcalcSlice) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_slice_max(s : MathtensorcalcSlice) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_slice_to_string(s : MathtensorcalcSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

