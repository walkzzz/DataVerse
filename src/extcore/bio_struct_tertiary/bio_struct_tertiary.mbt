///===
/// extcore/bio_struct_tertiary

pub(all) struct BiostructtertiaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_tertiary_make_point(x : Double, y : Double) -> BiostructtertiaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_tertiary_make_point3(x : Double, y : Double, z : Double) -> BiostructtertiaryPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructtertiaryPoint::x(self : BiostructtertiaryPoint) -> Double { self.x }

pub fn BiostructtertiaryPoint::y(self : BiostructtertiaryPoint) -> Double { self.y }

pub fn BiostructtertiaryPoint::z(self : BiostructtertiaryPoint) -> Double { self.z }

pub fn BiostructtertiaryPoint::label(self : BiostructtertiaryPoint) -> Int { self.label }

pub fn BiostructtertiaryPoint::dist(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructtertiaryPoint::add(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructtertiaryPoint::sub(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructtertiaryPoint::scale(self : BiostructtertiaryPoint, s : Double) -> BiostructtertiaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructtertiaryPoint::dot(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructtertiaryPoint::cross(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructtertiaryPoint::norm(self : BiostructtertiaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructtertiaryPoint::normalize(self : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructtertiaryPoint::negate(self : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructtertiaryPoint::mid(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructtertiaryPoint::lerp(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint, t : Double) -> BiostructtertiaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructtertiaryPoint::to_string(self : BiostructtertiaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructtertiarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_tertiary_make_series(vals : Array[Double], name : String) -> BiostructtertiarySeries {
  { vals, name, meta: 0 }
}

pub fn BiostructtertiarySeries::len(self : BiostructtertiarySeries) -> Int { self.vals.length() }

pub fn BiostructtertiarySeries::sum(self : BiostructtertiarySeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructtertiarySeries::mean(self : BiostructtertiarySeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructtertiarySeries::min(self : BiostructtertiarySeries) -> Double { @_common.min(self.vals) }

pub fn BiostructtertiarySeries::max(self : BiostructtertiarySeries) -> Double { @_common.max(self.vals) }

pub fn BiostructtertiarySeries::range(self : BiostructtertiarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructtertiarySeries::variance(self : BiostructtertiarySeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructtertiarySeries::std(self : BiostructtertiarySeries) -> Double { @_common.std(self.vals) }

pub fn BiostructtertiarySeries::median(self : BiostructtertiarySeries) -> Double { @_common.median(self.vals) }

pub fn BiostructtertiarySeries::scale(self : BiostructtertiarySeries, f : Double) -> BiostructtertiarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructtertiarySeries::add(self : BiostructtertiarySeries, other : BiostructtertiarySeries) -> BiostructtertiarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructtertiarySeries::sub(self : BiostructtertiarySeries, other : BiostructtertiarySeries) -> BiostructtertiarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructtertiarySeries::normalize(self : BiostructtertiarySeries) -> BiostructtertiarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructtertiarySeries::cumsum(self : BiostructtertiarySeries) -> BiostructtertiarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructtertiarySeries::to_string(self : BiostructtertiarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructtertiaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_tertiary_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructtertiaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_tertiary_matrix_identity(n : Int) -> BiostructtertiaryMatrix {
  let m = bio_struct_tertiary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructtertiaryMatrix::get(self : BiostructtertiaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructtertiaryMatrix::transpose(self : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  let result = bio_struct_tertiary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructtertiaryMatrix::add(self : BiostructtertiaryMatrix, other : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_tertiary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructtertiaryMatrix::scale(self : BiostructtertiaryMatrix, s : Double) -> BiostructtertiaryMatrix {
  let result = bio_struct_tertiary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructtertiaryMatrix::multiply(self : BiostructtertiaryMatrix, other : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  if self.cols != other.rows { return bio_struct_tertiary_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_tertiary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructtertiaryMatrix::trace(self : BiostructtertiaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructtertiaryMatrix::det(self : BiostructtertiaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructtertiaryMatrix::norm(self : BiostructtertiaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructtertiaryMatrix::to_string(self : BiostructtertiaryMatrix) -> String {
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

pub(all) struct BiostructtertiaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_tertiary_make_vector(comps : Array[Double]) -> BiostructtertiaryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_tertiary_vector_zero(dim : Int) -> BiostructtertiaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructtertiaryVector::add(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructtertiaryVector::sub(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructtertiaryVector::scale(self : BiostructtertiaryVector, s : Double) -> BiostructtertiaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructtertiaryVector::dot(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructtertiaryVector::norm(self : BiostructtertiaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructtertiaryVector::normalize(self : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructtertiaryVector::dist(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructtertiaryVector::to_string(self : BiostructtertiaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_tertiary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_tertiary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_tertiary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_tertiary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_tertiary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_tertiary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_tertiary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_tertiary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_tertiary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_tertiary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_tertiary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_tertiary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_tertiary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_tertiary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_tertiary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_tertiary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_tertiary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_tertiary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_tertiary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_tertiary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_tertiary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_tertiary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_tertiary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_tertiary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_tertiary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_tertiary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_tertiary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_tertiary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_tertiary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructtertiaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_frame_make(size : Int) -> BiostructtertiaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_frame_len(s : BiostructtertiaryFrame) -> Int { s.size }

pub fn bio_struct_tertiary_frame_get(s : BiostructtertiaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_frame_set(s : BiostructtertiaryFrame, i : Int, v : Double) -> BiostructtertiaryFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_frame_sum(s : BiostructtertiaryFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_frame_mean(s : BiostructtertiaryFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_frame_scale(s : BiostructtertiaryFrame, f : Double) -> BiostructtertiaryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_frame_add(a : BiostructtertiaryFrame, b : BiostructtertiaryFrame) -> BiostructtertiaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_frame_copy(s : BiostructtertiaryFrame) -> BiostructtertiaryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_frame_fill(s : BiostructtertiaryFrame, v : Double) -> BiostructtertiaryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_frame_min(s : BiostructtertiaryFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_frame_max(s : BiostructtertiaryFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_frame_to_string(s : BiostructtertiaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_table_make(size : Int) -> BiostructtertiaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_table_len(s : BiostructtertiaryTable) -> Int { s.size }

pub fn bio_struct_tertiary_table_get(s : BiostructtertiaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_table_set(s : BiostructtertiaryTable, i : Int, v : Double) -> BiostructtertiaryTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_table_sum(s : BiostructtertiaryTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_table_mean(s : BiostructtertiaryTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_table_scale(s : BiostructtertiaryTable, f : Double) -> BiostructtertiaryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_table_add(a : BiostructtertiaryTable, b : BiostructtertiaryTable) -> BiostructtertiaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_table_copy(s : BiostructtertiaryTable) -> BiostructtertiaryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_table_fill(s : BiostructtertiaryTable, v : Double) -> BiostructtertiaryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_table_min(s : BiostructtertiaryTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_table_max(s : BiostructtertiaryTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_table_to_string(s : BiostructtertiaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_graphn_make(size : Int) -> BiostructtertiaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_graphn_len(s : BiostructtertiaryGraphN) -> Int { s.size }

pub fn bio_struct_tertiary_graphn_get(s : BiostructtertiaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_graphn_set(s : BiostructtertiaryGraphN, i : Int, v : Double) -> BiostructtertiaryGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_graphn_sum(s : BiostructtertiaryGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_graphn_mean(s : BiostructtertiaryGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_graphn_scale(s : BiostructtertiaryGraphN, f : Double) -> BiostructtertiaryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_graphn_add(a : BiostructtertiaryGraphN, b : BiostructtertiaryGraphN) -> BiostructtertiaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_graphn_copy(s : BiostructtertiaryGraphN) -> BiostructtertiaryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_graphn_fill(s : BiostructtertiaryGraphN, v : Double) -> BiostructtertiaryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_graphn_min(s : BiostructtertiaryGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_graphn_max(s : BiostructtertiaryGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_graphn_to_string(s : BiostructtertiaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_node_make(size : Int) -> BiostructtertiaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_node_len(s : BiostructtertiaryNode) -> Int { s.size }

pub fn bio_struct_tertiary_node_get(s : BiostructtertiaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_node_set(s : BiostructtertiaryNode, i : Int, v : Double) -> BiostructtertiaryNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_node_sum(s : BiostructtertiaryNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_node_mean(s : BiostructtertiaryNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_node_scale(s : BiostructtertiaryNode, f : Double) -> BiostructtertiaryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_node_add(a : BiostructtertiaryNode, b : BiostructtertiaryNode) -> BiostructtertiaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_node_copy(s : BiostructtertiaryNode) -> BiostructtertiaryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_node_fill(s : BiostructtertiaryNode, v : Double) -> BiostructtertiaryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_node_min(s : BiostructtertiaryNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_node_max(s : BiostructtertiaryNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_node_to_string(s : BiostructtertiaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_edge_make(size : Int) -> BiostructtertiaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_edge_len(s : BiostructtertiaryEdge) -> Int { s.size }

pub fn bio_struct_tertiary_edge_get(s : BiostructtertiaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_edge_set(s : BiostructtertiaryEdge, i : Int, v : Double) -> BiostructtertiaryEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_edge_sum(s : BiostructtertiaryEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_edge_mean(s : BiostructtertiaryEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_edge_scale(s : BiostructtertiaryEdge, f : Double) -> BiostructtertiaryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_edge_add(a : BiostructtertiaryEdge, b : BiostructtertiaryEdge) -> BiostructtertiaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_edge_copy(s : BiostructtertiaryEdge) -> BiostructtertiaryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_edge_fill(s : BiostructtertiaryEdge, v : Double) -> BiostructtertiaryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_edge_min(s : BiostructtertiaryEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_edge_max(s : BiostructtertiaryEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_edge_to_string(s : BiostructtertiaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_path_make(size : Int) -> BiostructtertiaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_path_len(s : BiostructtertiaryPath) -> Int { s.size }

pub fn bio_struct_tertiary_path_get(s : BiostructtertiaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_path_set(s : BiostructtertiaryPath, i : Int, v : Double) -> BiostructtertiaryPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_path_sum(s : BiostructtertiaryPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_path_mean(s : BiostructtertiaryPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_path_scale(s : BiostructtertiaryPath, f : Double) -> BiostructtertiaryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_path_add(a : BiostructtertiaryPath, b : BiostructtertiaryPath) -> BiostructtertiaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_path_copy(s : BiostructtertiaryPath) -> BiostructtertiaryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_path_fill(s : BiostructtertiaryPath, v : Double) -> BiostructtertiaryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_path_min(s : BiostructtertiaryPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_path_max(s : BiostructtertiaryPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_path_to_string(s : BiostructtertiaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_cluster_make(size : Int) -> BiostructtertiaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_cluster_len(s : BiostructtertiaryCluster) -> Int { s.size }

pub fn bio_struct_tertiary_cluster_get(s : BiostructtertiaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_cluster_set(s : BiostructtertiaryCluster, i : Int, v : Double) -> BiostructtertiaryCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cluster_sum(s : BiostructtertiaryCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_cluster_mean(s : BiostructtertiaryCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_cluster_scale(s : BiostructtertiaryCluster, f : Double) -> BiostructtertiaryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cluster_add(a : BiostructtertiaryCluster, b : BiostructtertiaryCluster) -> BiostructtertiaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_cluster_copy(s : BiostructtertiaryCluster) -> BiostructtertiaryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cluster_fill(s : BiostructtertiaryCluster, v : Double) -> BiostructtertiaryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cluster_min(s : BiostructtertiaryCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_cluster_max(s : BiostructtertiaryCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_cluster_to_string(s : BiostructtertiaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_model_make(size : Int) -> BiostructtertiaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_model_len(s : BiostructtertiaryModel) -> Int { s.size }

pub fn bio_struct_tertiary_model_get(s : BiostructtertiaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_model_set(s : BiostructtertiaryModel, i : Int, v : Double) -> BiostructtertiaryModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_model_sum(s : BiostructtertiaryModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_model_mean(s : BiostructtertiaryModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_model_scale(s : BiostructtertiaryModel, f : Double) -> BiostructtertiaryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_model_add(a : BiostructtertiaryModel, b : BiostructtertiaryModel) -> BiostructtertiaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_model_copy(s : BiostructtertiaryModel) -> BiostructtertiaryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_model_fill(s : BiostructtertiaryModel, v : Double) -> BiostructtertiaryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_model_min(s : BiostructtertiaryModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_model_max(s : BiostructtertiaryModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_model_to_string(s : BiostructtertiaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_layer_make(size : Int) -> BiostructtertiaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_layer_len(s : BiostructtertiaryLayer) -> Int { s.size }

pub fn bio_struct_tertiary_layer_get(s : BiostructtertiaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_layer_set(s : BiostructtertiaryLayer, i : Int, v : Double) -> BiostructtertiaryLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_layer_sum(s : BiostructtertiaryLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_layer_mean(s : BiostructtertiaryLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_layer_scale(s : BiostructtertiaryLayer, f : Double) -> BiostructtertiaryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_layer_add(a : BiostructtertiaryLayer, b : BiostructtertiaryLayer) -> BiostructtertiaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_layer_copy(s : BiostructtertiaryLayer) -> BiostructtertiaryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_layer_fill(s : BiostructtertiaryLayer, v : Double) -> BiostructtertiaryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_layer_min(s : BiostructtertiaryLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_layer_max(s : BiostructtertiaryLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_layer_to_string(s : BiostructtertiaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_buffer_make(size : Int) -> BiostructtertiaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_buffer_len(s : BiostructtertiaryBuffer) -> Int { s.size }

pub fn bio_struct_tertiary_buffer_get(s : BiostructtertiaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_buffer_set(s : BiostructtertiaryBuffer, i : Int, v : Double) -> BiostructtertiaryBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_buffer_sum(s : BiostructtertiaryBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_buffer_mean(s : BiostructtertiaryBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_buffer_scale(s : BiostructtertiaryBuffer, f : Double) -> BiostructtertiaryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_buffer_add(a : BiostructtertiaryBuffer, b : BiostructtertiaryBuffer) -> BiostructtertiaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_buffer_copy(s : BiostructtertiaryBuffer) -> BiostructtertiaryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_buffer_fill(s : BiostructtertiaryBuffer, v : Double) -> BiostructtertiaryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_buffer_min(s : BiostructtertiaryBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_buffer_max(s : BiostructtertiaryBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_buffer_to_string(s : BiostructtertiaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_cursor_make(size : Int) -> BiostructtertiaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_cursor_len(s : BiostructtertiaryCursor) -> Int { s.size }

pub fn bio_struct_tertiary_cursor_get(s : BiostructtertiaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_cursor_set(s : BiostructtertiaryCursor, i : Int, v : Double) -> BiostructtertiaryCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cursor_sum(s : BiostructtertiaryCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_cursor_mean(s : BiostructtertiaryCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_cursor_scale(s : BiostructtertiaryCursor, f : Double) -> BiostructtertiaryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cursor_add(a : BiostructtertiaryCursor, b : BiostructtertiaryCursor) -> BiostructtertiaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_cursor_copy(s : BiostructtertiaryCursor) -> BiostructtertiaryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cursor_fill(s : BiostructtertiaryCursor, v : Double) -> BiostructtertiaryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_cursor_min(s : BiostructtertiaryCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_cursor_max(s : BiostructtertiaryCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_cursor_to_string(s : BiostructtertiaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_view_make(size : Int) -> BiostructtertiaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_view_len(s : BiostructtertiaryView) -> Int { s.size }

pub fn bio_struct_tertiary_view_get(s : BiostructtertiaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_view_set(s : BiostructtertiaryView, i : Int, v : Double) -> BiostructtertiaryView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_view_sum(s : BiostructtertiaryView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_view_mean(s : BiostructtertiaryView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_view_scale(s : BiostructtertiaryView, f : Double) -> BiostructtertiaryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_view_add(a : BiostructtertiaryView, b : BiostructtertiaryView) -> BiostructtertiaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_view_copy(s : BiostructtertiaryView) -> BiostructtertiaryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_view_fill(s : BiostructtertiaryView, v : Double) -> BiostructtertiaryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_view_min(s : BiostructtertiaryView) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_view_max(s : BiostructtertiaryView) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_view_to_string(s : BiostructtertiaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_range_make(size : Int) -> BiostructtertiaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_range_len(s : BiostructtertiaryRange) -> Int { s.size }

pub fn bio_struct_tertiary_range_get(s : BiostructtertiaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_range_set(s : BiostructtertiaryRange, i : Int, v : Double) -> BiostructtertiaryRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_range_sum(s : BiostructtertiaryRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_range_mean(s : BiostructtertiaryRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_range_scale(s : BiostructtertiaryRange, f : Double) -> BiostructtertiaryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_range_add(a : BiostructtertiaryRange, b : BiostructtertiaryRange) -> BiostructtertiaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_range_copy(s : BiostructtertiaryRange) -> BiostructtertiaryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_range_fill(s : BiostructtertiaryRange, v : Double) -> BiostructtertiaryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_range_min(s : BiostructtertiaryRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_range_max(s : BiostructtertiaryRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_range_to_string(s : BiostructtertiaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_slice_make(size : Int) -> BiostructtertiarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_slice_len(s : BiostructtertiarySlice) -> Int { s.size }

pub fn bio_struct_tertiary_slice_get(s : BiostructtertiarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_slice_set(s : BiostructtertiarySlice, i : Int, v : Double) -> BiostructtertiarySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_slice_sum(s : BiostructtertiarySlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_tertiary_slice_mean(s : BiostructtertiarySlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_tertiary_slice_scale(s : BiostructtertiarySlice, f : Double) -> BiostructtertiarySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_slice_add(a : BiostructtertiarySlice, b : BiostructtertiarySlice) -> BiostructtertiarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_tertiary_slice_copy(s : BiostructtertiarySlice) -> BiostructtertiarySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_slice_fill(s : BiostructtertiarySlice, v : Double) -> BiostructtertiarySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_tertiary_slice_min(s : BiostructtertiarySlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_tertiary_slice_max(s : BiostructtertiarySlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_tertiary_slice_to_string(s : BiostructtertiarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

