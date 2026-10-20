///===
/// extcore/math_complementarity

pub(all) struct MathcomplementarityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_complementarity_make_point(x : Double, y : Double) -> MathcomplementarityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_complementarity_make_point3(x : Double, y : Double, z : Double) -> MathcomplementarityPoint {
  { x, y, z, label: 0 }
}

pub fn MathcomplementarityPoint::x(self : MathcomplementarityPoint) -> Double { self.x }

pub fn MathcomplementarityPoint::y(self : MathcomplementarityPoint) -> Double { self.y }

pub fn MathcomplementarityPoint::z(self : MathcomplementarityPoint) -> Double { self.z }

pub fn MathcomplementarityPoint::label(self : MathcomplementarityPoint) -> Int { self.label }

pub fn MathcomplementarityPoint::dist(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathcomplementarityPoint::add(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathcomplementarityPoint::sub(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathcomplementarityPoint::scale(self : MathcomplementarityPoint, s : Double) -> MathcomplementarityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathcomplementarityPoint::dot(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathcomplementarityPoint::cross(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathcomplementarityPoint::norm(self : MathcomplementarityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathcomplementarityPoint::normalize(self : MathcomplementarityPoint) -> MathcomplementarityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcomplementarityPoint::negate(self : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathcomplementarityPoint::mid(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathcomplementarityPoint::lerp(self : MathcomplementarityPoint, other : MathcomplementarityPoint, t : Double) -> MathcomplementarityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathcomplementarityPoint::to_string(self : MathcomplementarityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathcomplementaritySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_complementarity_make_series(vals : Array[Double], name : String) -> MathcomplementaritySeries {
  { vals, name, meta: 0 }
}

pub fn MathcomplementaritySeries::len(self : MathcomplementaritySeries) -> Int { self.vals.length() }

pub fn MathcomplementaritySeries::sum(self : MathcomplementaritySeries) -> Double { @_common.sum(self.vals) }

pub fn MathcomplementaritySeries::mean(self : MathcomplementaritySeries) -> Double { @_common.mean(self.vals) }

pub fn MathcomplementaritySeries::min(self : MathcomplementaritySeries) -> Double { @_common.min(self.vals) }

pub fn MathcomplementaritySeries::max(self : MathcomplementaritySeries) -> Double { @_common.max(self.vals) }

pub fn MathcomplementaritySeries::range(self : MathcomplementaritySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathcomplementaritySeries::variance(self : MathcomplementaritySeries) -> Double { @_common.variance(self.vals) }

pub fn MathcomplementaritySeries::std(self : MathcomplementaritySeries) -> Double { @_common.std(self.vals) }

pub fn MathcomplementaritySeries::median(self : MathcomplementaritySeries) -> Double { @_common.median(self.vals) }

pub fn MathcomplementaritySeries::scale(self : MathcomplementaritySeries, f : Double) -> MathcomplementaritySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathcomplementaritySeries::add(self : MathcomplementaritySeries, other : MathcomplementaritySeries) -> MathcomplementaritySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathcomplementaritySeries::sub(self : MathcomplementaritySeries, other : MathcomplementaritySeries) -> MathcomplementaritySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathcomplementaritySeries::normalize(self : MathcomplementaritySeries) -> MathcomplementaritySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathcomplementaritySeries::cumsum(self : MathcomplementaritySeries) -> MathcomplementaritySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathcomplementaritySeries::to_string(self : MathcomplementaritySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcomplementarityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_complementarity_make_matrix(rows : Int, cols : Int, val : Double) -> MathcomplementarityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_complementarity_matrix_identity(n : Int) -> MathcomplementarityMatrix {
  let m = math_complementarity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathcomplementarityMatrix::get(self : MathcomplementarityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathcomplementarityMatrix::transpose(self : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  let result = math_complementarity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathcomplementarityMatrix::add(self : MathcomplementarityMatrix, other : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_complementarity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathcomplementarityMatrix::scale(self : MathcomplementarityMatrix, s : Double) -> MathcomplementarityMatrix {
  let result = math_complementarity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathcomplementarityMatrix::multiply(self : MathcomplementarityMatrix, other : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  if self.cols != other.rows { return math_complementarity_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_complementarity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathcomplementarityMatrix::trace(self : MathcomplementarityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathcomplementarityMatrix::det(self : MathcomplementarityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathcomplementarityMatrix::norm(self : MathcomplementarityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathcomplementarityMatrix::to_string(self : MathcomplementarityMatrix) -> String {
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

pub(all) struct MathcomplementarityVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_complementarity_make_vector(comps : Array[Double]) -> MathcomplementarityVector {
  { comps, dim: comps.length() }
}

pub fn math_complementarity_vector_zero(dim : Int) -> MathcomplementarityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathcomplementarityVector::add(self : MathcomplementarityVector, other : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathcomplementarityVector::sub(self : MathcomplementarityVector, other : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathcomplementarityVector::scale(self : MathcomplementarityVector, s : Double) -> MathcomplementarityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathcomplementarityVector::dot(self : MathcomplementarityVector, other : MathcomplementarityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathcomplementarityVector::norm(self : MathcomplementarityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathcomplementarityVector::normalize(self : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcomplementarityVector::dist(self : MathcomplementarityVector, other : MathcomplementarityVector) -> Double {
  self.sub(other).norm()
}

pub fn MathcomplementarityVector::to_string(self : MathcomplementarityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_complementarity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_complementarity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_complementarity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_complementarity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_complementarity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_complementarity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_complementarity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_complementarity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_complementarity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_complementarity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_complementarity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_complementarity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_complementarity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_complementarity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_complementarity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_complementarity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_complementarity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_complementarity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_complementarity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_complementarity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_complementarity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_complementarity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_complementarity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_complementarity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_complementarity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_complementarity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_complementarity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_complementarity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_complementarity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathcomplementarityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_frame_make(size : Int) -> MathcomplementarityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_frame_len(s : MathcomplementarityFrame) -> Int { s.size }

pub fn math_complementarity_frame_get(s : MathcomplementarityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_frame_set(s : MathcomplementarityFrame, i : Int, v : Double) -> MathcomplementarityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_frame_sum(s : MathcomplementarityFrame) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_frame_mean(s : MathcomplementarityFrame) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_frame_scale(s : MathcomplementarityFrame, f : Double) -> MathcomplementarityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_frame_add(a : MathcomplementarityFrame, b : MathcomplementarityFrame) -> MathcomplementarityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_frame_copy(s : MathcomplementarityFrame) -> MathcomplementarityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_frame_fill(s : MathcomplementarityFrame, v : Double) -> MathcomplementarityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_frame_min(s : MathcomplementarityFrame) -> Double { @_common.min(s.data) }

pub fn math_complementarity_frame_max(s : MathcomplementarityFrame) -> Double { @_common.max(s.data) }

pub fn math_complementarity_frame_to_string(s : MathcomplementarityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_table_make(size : Int) -> MathcomplementarityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_table_len(s : MathcomplementarityTable) -> Int { s.size }

pub fn math_complementarity_table_get(s : MathcomplementarityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_table_set(s : MathcomplementarityTable, i : Int, v : Double) -> MathcomplementarityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_table_sum(s : MathcomplementarityTable) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_table_mean(s : MathcomplementarityTable) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_table_scale(s : MathcomplementarityTable, f : Double) -> MathcomplementarityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_table_add(a : MathcomplementarityTable, b : MathcomplementarityTable) -> MathcomplementarityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_table_copy(s : MathcomplementarityTable) -> MathcomplementarityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_table_fill(s : MathcomplementarityTable, v : Double) -> MathcomplementarityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_table_min(s : MathcomplementarityTable) -> Double { @_common.min(s.data) }

pub fn math_complementarity_table_max(s : MathcomplementarityTable) -> Double { @_common.max(s.data) }

pub fn math_complementarity_table_to_string(s : MathcomplementarityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_graphn_make(size : Int) -> MathcomplementarityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_graphn_len(s : MathcomplementarityGraphN) -> Int { s.size }

pub fn math_complementarity_graphn_get(s : MathcomplementarityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_graphn_set(s : MathcomplementarityGraphN, i : Int, v : Double) -> MathcomplementarityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_graphn_sum(s : MathcomplementarityGraphN) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_graphn_mean(s : MathcomplementarityGraphN) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_graphn_scale(s : MathcomplementarityGraphN, f : Double) -> MathcomplementarityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_graphn_add(a : MathcomplementarityGraphN, b : MathcomplementarityGraphN) -> MathcomplementarityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_graphn_copy(s : MathcomplementarityGraphN) -> MathcomplementarityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_graphn_fill(s : MathcomplementarityGraphN, v : Double) -> MathcomplementarityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_graphn_min(s : MathcomplementarityGraphN) -> Double { @_common.min(s.data) }

pub fn math_complementarity_graphn_max(s : MathcomplementarityGraphN) -> Double { @_common.max(s.data) }

pub fn math_complementarity_graphn_to_string(s : MathcomplementarityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_node_make(size : Int) -> MathcomplementarityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_node_len(s : MathcomplementarityNode) -> Int { s.size }

pub fn math_complementarity_node_get(s : MathcomplementarityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_node_set(s : MathcomplementarityNode, i : Int, v : Double) -> MathcomplementarityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_node_sum(s : MathcomplementarityNode) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_node_mean(s : MathcomplementarityNode) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_node_scale(s : MathcomplementarityNode, f : Double) -> MathcomplementarityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_node_add(a : MathcomplementarityNode, b : MathcomplementarityNode) -> MathcomplementarityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_node_copy(s : MathcomplementarityNode) -> MathcomplementarityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_node_fill(s : MathcomplementarityNode, v : Double) -> MathcomplementarityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_node_min(s : MathcomplementarityNode) -> Double { @_common.min(s.data) }

pub fn math_complementarity_node_max(s : MathcomplementarityNode) -> Double { @_common.max(s.data) }

pub fn math_complementarity_node_to_string(s : MathcomplementarityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_edge_make(size : Int) -> MathcomplementarityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_edge_len(s : MathcomplementarityEdge) -> Int { s.size }

pub fn math_complementarity_edge_get(s : MathcomplementarityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_edge_set(s : MathcomplementarityEdge, i : Int, v : Double) -> MathcomplementarityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_edge_sum(s : MathcomplementarityEdge) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_edge_mean(s : MathcomplementarityEdge) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_edge_scale(s : MathcomplementarityEdge, f : Double) -> MathcomplementarityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_edge_add(a : MathcomplementarityEdge, b : MathcomplementarityEdge) -> MathcomplementarityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_edge_copy(s : MathcomplementarityEdge) -> MathcomplementarityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_edge_fill(s : MathcomplementarityEdge, v : Double) -> MathcomplementarityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_edge_min(s : MathcomplementarityEdge) -> Double { @_common.min(s.data) }

pub fn math_complementarity_edge_max(s : MathcomplementarityEdge) -> Double { @_common.max(s.data) }

pub fn math_complementarity_edge_to_string(s : MathcomplementarityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_path_make(size : Int) -> MathcomplementarityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_path_len(s : MathcomplementarityPath) -> Int { s.size }

pub fn math_complementarity_path_get(s : MathcomplementarityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_path_set(s : MathcomplementarityPath, i : Int, v : Double) -> MathcomplementarityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_path_sum(s : MathcomplementarityPath) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_path_mean(s : MathcomplementarityPath) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_path_scale(s : MathcomplementarityPath, f : Double) -> MathcomplementarityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_path_add(a : MathcomplementarityPath, b : MathcomplementarityPath) -> MathcomplementarityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_path_copy(s : MathcomplementarityPath) -> MathcomplementarityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_path_fill(s : MathcomplementarityPath, v : Double) -> MathcomplementarityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_path_min(s : MathcomplementarityPath) -> Double { @_common.min(s.data) }

pub fn math_complementarity_path_max(s : MathcomplementarityPath) -> Double { @_common.max(s.data) }

pub fn math_complementarity_path_to_string(s : MathcomplementarityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_cluster_make(size : Int) -> MathcomplementarityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_cluster_len(s : MathcomplementarityCluster) -> Int { s.size }

pub fn math_complementarity_cluster_get(s : MathcomplementarityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_cluster_set(s : MathcomplementarityCluster, i : Int, v : Double) -> MathcomplementarityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_cluster_sum(s : MathcomplementarityCluster) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_cluster_mean(s : MathcomplementarityCluster) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_cluster_scale(s : MathcomplementarityCluster, f : Double) -> MathcomplementarityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_cluster_add(a : MathcomplementarityCluster, b : MathcomplementarityCluster) -> MathcomplementarityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_cluster_copy(s : MathcomplementarityCluster) -> MathcomplementarityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_cluster_fill(s : MathcomplementarityCluster, v : Double) -> MathcomplementarityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_cluster_min(s : MathcomplementarityCluster) -> Double { @_common.min(s.data) }

pub fn math_complementarity_cluster_max(s : MathcomplementarityCluster) -> Double { @_common.max(s.data) }

pub fn math_complementarity_cluster_to_string(s : MathcomplementarityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_model_make(size : Int) -> MathcomplementarityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_model_len(s : MathcomplementarityModel) -> Int { s.size }

pub fn math_complementarity_model_get(s : MathcomplementarityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_model_set(s : MathcomplementarityModel, i : Int, v : Double) -> MathcomplementarityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_model_sum(s : MathcomplementarityModel) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_model_mean(s : MathcomplementarityModel) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_model_scale(s : MathcomplementarityModel, f : Double) -> MathcomplementarityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_model_add(a : MathcomplementarityModel, b : MathcomplementarityModel) -> MathcomplementarityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_model_copy(s : MathcomplementarityModel) -> MathcomplementarityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_model_fill(s : MathcomplementarityModel, v : Double) -> MathcomplementarityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_model_min(s : MathcomplementarityModel) -> Double { @_common.min(s.data) }

pub fn math_complementarity_model_max(s : MathcomplementarityModel) -> Double { @_common.max(s.data) }

pub fn math_complementarity_model_to_string(s : MathcomplementarityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_layer_make(size : Int) -> MathcomplementarityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_layer_len(s : MathcomplementarityLayer) -> Int { s.size }

pub fn math_complementarity_layer_get(s : MathcomplementarityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_layer_set(s : MathcomplementarityLayer, i : Int, v : Double) -> MathcomplementarityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_layer_sum(s : MathcomplementarityLayer) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_layer_mean(s : MathcomplementarityLayer) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_layer_scale(s : MathcomplementarityLayer, f : Double) -> MathcomplementarityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_layer_add(a : MathcomplementarityLayer, b : MathcomplementarityLayer) -> MathcomplementarityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_layer_copy(s : MathcomplementarityLayer) -> MathcomplementarityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_layer_fill(s : MathcomplementarityLayer, v : Double) -> MathcomplementarityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_layer_min(s : MathcomplementarityLayer) -> Double { @_common.min(s.data) }

pub fn math_complementarity_layer_max(s : MathcomplementarityLayer) -> Double { @_common.max(s.data) }

pub fn math_complementarity_layer_to_string(s : MathcomplementarityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_buffer_make(size : Int) -> MathcomplementarityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_buffer_len(s : MathcomplementarityBuffer) -> Int { s.size }

pub fn math_complementarity_buffer_get(s : MathcomplementarityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_buffer_set(s : MathcomplementarityBuffer, i : Int, v : Double) -> MathcomplementarityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_buffer_sum(s : MathcomplementarityBuffer) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_buffer_mean(s : MathcomplementarityBuffer) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_buffer_scale(s : MathcomplementarityBuffer, f : Double) -> MathcomplementarityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_buffer_add(a : MathcomplementarityBuffer, b : MathcomplementarityBuffer) -> MathcomplementarityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_buffer_copy(s : MathcomplementarityBuffer) -> MathcomplementarityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_buffer_fill(s : MathcomplementarityBuffer, v : Double) -> MathcomplementarityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_buffer_min(s : MathcomplementarityBuffer) -> Double { @_common.min(s.data) }

pub fn math_complementarity_buffer_max(s : MathcomplementarityBuffer) -> Double { @_common.max(s.data) }

pub fn math_complementarity_buffer_to_string(s : MathcomplementarityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_cursor_make(size : Int) -> MathcomplementarityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_cursor_len(s : MathcomplementarityCursor) -> Int { s.size }

pub fn math_complementarity_cursor_get(s : MathcomplementarityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_cursor_set(s : MathcomplementarityCursor, i : Int, v : Double) -> MathcomplementarityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_cursor_sum(s : MathcomplementarityCursor) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_cursor_mean(s : MathcomplementarityCursor) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_cursor_scale(s : MathcomplementarityCursor, f : Double) -> MathcomplementarityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_cursor_add(a : MathcomplementarityCursor, b : MathcomplementarityCursor) -> MathcomplementarityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_cursor_copy(s : MathcomplementarityCursor) -> MathcomplementarityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_cursor_fill(s : MathcomplementarityCursor, v : Double) -> MathcomplementarityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_cursor_min(s : MathcomplementarityCursor) -> Double { @_common.min(s.data) }

pub fn math_complementarity_cursor_max(s : MathcomplementarityCursor) -> Double { @_common.max(s.data) }

pub fn math_complementarity_cursor_to_string(s : MathcomplementarityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_view_make(size : Int) -> MathcomplementarityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_view_len(s : MathcomplementarityView) -> Int { s.size }

pub fn math_complementarity_view_get(s : MathcomplementarityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_view_set(s : MathcomplementarityView, i : Int, v : Double) -> MathcomplementarityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_view_sum(s : MathcomplementarityView) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_view_mean(s : MathcomplementarityView) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_view_scale(s : MathcomplementarityView, f : Double) -> MathcomplementarityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_view_add(a : MathcomplementarityView, b : MathcomplementarityView) -> MathcomplementarityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_view_copy(s : MathcomplementarityView) -> MathcomplementarityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_view_fill(s : MathcomplementarityView, v : Double) -> MathcomplementarityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_view_min(s : MathcomplementarityView) -> Double { @_common.min(s.data) }

pub fn math_complementarity_view_max(s : MathcomplementarityView) -> Double { @_common.max(s.data) }

pub fn math_complementarity_view_to_string(s : MathcomplementarityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_range_make(size : Int) -> MathcomplementarityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_range_len(s : MathcomplementarityRange) -> Int { s.size }

pub fn math_complementarity_range_get(s : MathcomplementarityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_range_set(s : MathcomplementarityRange, i : Int, v : Double) -> MathcomplementarityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_range_sum(s : MathcomplementarityRange) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_range_mean(s : MathcomplementarityRange) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_range_scale(s : MathcomplementarityRange, f : Double) -> MathcomplementarityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_range_add(a : MathcomplementarityRange, b : MathcomplementarityRange) -> MathcomplementarityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_range_copy(s : MathcomplementarityRange) -> MathcomplementarityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_range_fill(s : MathcomplementarityRange, v : Double) -> MathcomplementarityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_range_min(s : MathcomplementarityRange) -> Double { @_common.min(s.data) }

pub fn math_complementarity_range_max(s : MathcomplementarityRange) -> Double { @_common.max(s.data) }

pub fn math_complementarity_range_to_string(s : MathcomplementarityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementaritySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_slice_make(size : Int) -> MathcomplementaritySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_slice_len(s : MathcomplementaritySlice) -> Int { s.size }

pub fn math_complementarity_slice_get(s : MathcomplementaritySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_slice_set(s : MathcomplementaritySlice, i : Int, v : Double) -> MathcomplementaritySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_complementarity_slice_sum(s : MathcomplementaritySlice) -> Double { @_common.sum(s.data) }

pub fn math_complementarity_slice_mean(s : MathcomplementaritySlice) -> Double { @_common.mean(s.data) }

pub fn math_complementarity_slice_scale(s : MathcomplementaritySlice, f : Double) -> MathcomplementaritySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_complementarity_slice_add(a : MathcomplementaritySlice, b : MathcomplementaritySlice) -> MathcomplementaritySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_complementarity_slice_copy(s : MathcomplementaritySlice) -> MathcomplementaritySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_complementarity_slice_fill(s : MathcomplementaritySlice, v : Double) -> MathcomplementaritySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_complementarity_slice_min(s : MathcomplementaritySlice) -> Double { @_common.min(s.data) }

pub fn math_complementarity_slice_max(s : MathcomplementaritySlice) -> Double { @_common.max(s.data) }

pub fn math_complementarity_slice_to_string(s : MathcomplementaritySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

