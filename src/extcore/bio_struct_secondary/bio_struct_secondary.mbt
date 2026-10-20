///===
/// extcore/bio_struct_secondary

pub(all) struct BiostructsecondaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_secondary_make_point(x : Double, y : Double) -> BiostructsecondaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_secondary_make_point3(x : Double, y : Double, z : Double) -> BiostructsecondaryPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructsecondaryPoint::x(self : BiostructsecondaryPoint) -> Double { self.x }

pub fn BiostructsecondaryPoint::y(self : BiostructsecondaryPoint) -> Double { self.y }

pub fn BiostructsecondaryPoint::z(self : BiostructsecondaryPoint) -> Double { self.z }

pub fn BiostructsecondaryPoint::label(self : BiostructsecondaryPoint) -> Int { self.label }

pub fn BiostructsecondaryPoint::dist(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructsecondaryPoint::add(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructsecondaryPoint::sub(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructsecondaryPoint::scale(self : BiostructsecondaryPoint, s : Double) -> BiostructsecondaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructsecondaryPoint::dot(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructsecondaryPoint::cross(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructsecondaryPoint::norm(self : BiostructsecondaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructsecondaryPoint::normalize(self : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsecondaryPoint::negate(self : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructsecondaryPoint::mid(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructsecondaryPoint::lerp(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint, t : Double) -> BiostructsecondaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructsecondaryPoint::to_string(self : BiostructsecondaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructsecondarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_secondary_make_series(vals : Array[Double], name : String) -> BiostructsecondarySeries {
  { vals, name, meta: 0 }
}

pub fn BiostructsecondarySeries::len(self : BiostructsecondarySeries) -> Int { self.vals.length() }

pub fn BiostructsecondarySeries::sum(self : BiostructsecondarySeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructsecondarySeries::mean(self : BiostructsecondarySeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructsecondarySeries::min(self : BiostructsecondarySeries) -> Double { @_common.min(self.vals) }

pub fn BiostructsecondarySeries::max(self : BiostructsecondarySeries) -> Double { @_common.max(self.vals) }

pub fn BiostructsecondarySeries::range(self : BiostructsecondarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructsecondarySeries::variance(self : BiostructsecondarySeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructsecondarySeries::std(self : BiostructsecondarySeries) -> Double { @_common.std(self.vals) }

pub fn BiostructsecondarySeries::median(self : BiostructsecondarySeries) -> Double { @_common.median(self.vals) }

pub fn BiostructsecondarySeries::scale(self : BiostructsecondarySeries, f : Double) -> BiostructsecondarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructsecondarySeries::add(self : BiostructsecondarySeries, other : BiostructsecondarySeries) -> BiostructsecondarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructsecondarySeries::sub(self : BiostructsecondarySeries, other : BiostructsecondarySeries) -> BiostructsecondarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructsecondarySeries::normalize(self : BiostructsecondarySeries) -> BiostructsecondarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructsecondarySeries::cumsum(self : BiostructsecondarySeries) -> BiostructsecondarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructsecondarySeries::to_string(self : BiostructsecondarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsecondaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_secondary_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsecondaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_secondary_matrix_identity(n : Int) -> BiostructsecondaryMatrix {
  let m = bio_struct_secondary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructsecondaryMatrix::get(self : BiostructsecondaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructsecondaryMatrix::transpose(self : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  let result = bio_struct_secondary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructsecondaryMatrix::add(self : BiostructsecondaryMatrix, other : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_secondary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructsecondaryMatrix::scale(self : BiostructsecondaryMatrix, s : Double) -> BiostructsecondaryMatrix {
  let result = bio_struct_secondary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructsecondaryMatrix::multiply(self : BiostructsecondaryMatrix, other : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  if self.cols != other.rows { return bio_struct_secondary_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_secondary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructsecondaryMatrix::trace(self : BiostructsecondaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructsecondaryMatrix::det(self : BiostructsecondaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructsecondaryMatrix::norm(self : BiostructsecondaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructsecondaryMatrix::to_string(self : BiostructsecondaryMatrix) -> String {
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

pub(all) struct BiostructsecondaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_secondary_make_vector(comps : Array[Double]) -> BiostructsecondaryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_secondary_vector_zero(dim : Int) -> BiostructsecondaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructsecondaryVector::add(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsecondaryVector::sub(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsecondaryVector::scale(self : BiostructsecondaryVector, s : Double) -> BiostructsecondaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructsecondaryVector::dot(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructsecondaryVector::norm(self : BiostructsecondaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructsecondaryVector::normalize(self : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsecondaryVector::dist(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructsecondaryVector::to_string(self : BiostructsecondaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_secondary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_secondary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_secondary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_secondary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_secondary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_secondary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_secondary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_secondary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_secondary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_secondary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_secondary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_secondary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_secondary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_secondary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_secondary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_secondary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_secondary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_secondary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_secondary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_secondary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_secondary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_secondary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_secondary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_secondary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_secondary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_secondary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_secondary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_secondary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_secondary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructsecondaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_frame_make(size : Int) -> BiostructsecondaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_frame_len(s : BiostructsecondaryFrame) -> Int { s.size }

pub fn bio_struct_secondary_frame_get(s : BiostructsecondaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_frame_set(s : BiostructsecondaryFrame, i : Int, v : Double) -> BiostructsecondaryFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_frame_sum(s : BiostructsecondaryFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_frame_mean(s : BiostructsecondaryFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_frame_scale(s : BiostructsecondaryFrame, f : Double) -> BiostructsecondaryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_frame_add(a : BiostructsecondaryFrame, b : BiostructsecondaryFrame) -> BiostructsecondaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_frame_copy(s : BiostructsecondaryFrame) -> BiostructsecondaryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_frame_fill(s : BiostructsecondaryFrame, v : Double) -> BiostructsecondaryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_frame_min(s : BiostructsecondaryFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_frame_max(s : BiostructsecondaryFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_frame_to_string(s : BiostructsecondaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_table_make(size : Int) -> BiostructsecondaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_table_len(s : BiostructsecondaryTable) -> Int { s.size }

pub fn bio_struct_secondary_table_get(s : BiostructsecondaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_table_set(s : BiostructsecondaryTable, i : Int, v : Double) -> BiostructsecondaryTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_table_sum(s : BiostructsecondaryTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_table_mean(s : BiostructsecondaryTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_table_scale(s : BiostructsecondaryTable, f : Double) -> BiostructsecondaryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_table_add(a : BiostructsecondaryTable, b : BiostructsecondaryTable) -> BiostructsecondaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_table_copy(s : BiostructsecondaryTable) -> BiostructsecondaryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_table_fill(s : BiostructsecondaryTable, v : Double) -> BiostructsecondaryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_table_min(s : BiostructsecondaryTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_table_max(s : BiostructsecondaryTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_table_to_string(s : BiostructsecondaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_graphn_make(size : Int) -> BiostructsecondaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_graphn_len(s : BiostructsecondaryGraphN) -> Int { s.size }

pub fn bio_struct_secondary_graphn_get(s : BiostructsecondaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_graphn_set(s : BiostructsecondaryGraphN, i : Int, v : Double) -> BiostructsecondaryGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_graphn_sum(s : BiostructsecondaryGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_graphn_mean(s : BiostructsecondaryGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_graphn_scale(s : BiostructsecondaryGraphN, f : Double) -> BiostructsecondaryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_graphn_add(a : BiostructsecondaryGraphN, b : BiostructsecondaryGraphN) -> BiostructsecondaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_graphn_copy(s : BiostructsecondaryGraphN) -> BiostructsecondaryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_graphn_fill(s : BiostructsecondaryGraphN, v : Double) -> BiostructsecondaryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_graphn_min(s : BiostructsecondaryGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_graphn_max(s : BiostructsecondaryGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_graphn_to_string(s : BiostructsecondaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_node_make(size : Int) -> BiostructsecondaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_node_len(s : BiostructsecondaryNode) -> Int { s.size }

pub fn bio_struct_secondary_node_get(s : BiostructsecondaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_node_set(s : BiostructsecondaryNode, i : Int, v : Double) -> BiostructsecondaryNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_node_sum(s : BiostructsecondaryNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_node_mean(s : BiostructsecondaryNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_node_scale(s : BiostructsecondaryNode, f : Double) -> BiostructsecondaryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_node_add(a : BiostructsecondaryNode, b : BiostructsecondaryNode) -> BiostructsecondaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_node_copy(s : BiostructsecondaryNode) -> BiostructsecondaryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_node_fill(s : BiostructsecondaryNode, v : Double) -> BiostructsecondaryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_node_min(s : BiostructsecondaryNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_node_max(s : BiostructsecondaryNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_node_to_string(s : BiostructsecondaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_edge_make(size : Int) -> BiostructsecondaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_edge_len(s : BiostructsecondaryEdge) -> Int { s.size }

pub fn bio_struct_secondary_edge_get(s : BiostructsecondaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_edge_set(s : BiostructsecondaryEdge, i : Int, v : Double) -> BiostructsecondaryEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_edge_sum(s : BiostructsecondaryEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_edge_mean(s : BiostructsecondaryEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_edge_scale(s : BiostructsecondaryEdge, f : Double) -> BiostructsecondaryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_edge_add(a : BiostructsecondaryEdge, b : BiostructsecondaryEdge) -> BiostructsecondaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_edge_copy(s : BiostructsecondaryEdge) -> BiostructsecondaryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_edge_fill(s : BiostructsecondaryEdge, v : Double) -> BiostructsecondaryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_edge_min(s : BiostructsecondaryEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_edge_max(s : BiostructsecondaryEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_edge_to_string(s : BiostructsecondaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_path_make(size : Int) -> BiostructsecondaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_path_len(s : BiostructsecondaryPath) -> Int { s.size }

pub fn bio_struct_secondary_path_get(s : BiostructsecondaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_path_set(s : BiostructsecondaryPath, i : Int, v : Double) -> BiostructsecondaryPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_path_sum(s : BiostructsecondaryPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_path_mean(s : BiostructsecondaryPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_path_scale(s : BiostructsecondaryPath, f : Double) -> BiostructsecondaryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_path_add(a : BiostructsecondaryPath, b : BiostructsecondaryPath) -> BiostructsecondaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_path_copy(s : BiostructsecondaryPath) -> BiostructsecondaryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_path_fill(s : BiostructsecondaryPath, v : Double) -> BiostructsecondaryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_path_min(s : BiostructsecondaryPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_path_max(s : BiostructsecondaryPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_path_to_string(s : BiostructsecondaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_cluster_make(size : Int) -> BiostructsecondaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_cluster_len(s : BiostructsecondaryCluster) -> Int { s.size }

pub fn bio_struct_secondary_cluster_get(s : BiostructsecondaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_cluster_set(s : BiostructsecondaryCluster, i : Int, v : Double) -> BiostructsecondaryCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cluster_sum(s : BiostructsecondaryCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_cluster_mean(s : BiostructsecondaryCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_cluster_scale(s : BiostructsecondaryCluster, f : Double) -> BiostructsecondaryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cluster_add(a : BiostructsecondaryCluster, b : BiostructsecondaryCluster) -> BiostructsecondaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_cluster_copy(s : BiostructsecondaryCluster) -> BiostructsecondaryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cluster_fill(s : BiostructsecondaryCluster, v : Double) -> BiostructsecondaryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cluster_min(s : BiostructsecondaryCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_cluster_max(s : BiostructsecondaryCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_cluster_to_string(s : BiostructsecondaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_model_make(size : Int) -> BiostructsecondaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_model_len(s : BiostructsecondaryModel) -> Int { s.size }

pub fn bio_struct_secondary_model_get(s : BiostructsecondaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_model_set(s : BiostructsecondaryModel, i : Int, v : Double) -> BiostructsecondaryModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_model_sum(s : BiostructsecondaryModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_model_mean(s : BiostructsecondaryModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_model_scale(s : BiostructsecondaryModel, f : Double) -> BiostructsecondaryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_model_add(a : BiostructsecondaryModel, b : BiostructsecondaryModel) -> BiostructsecondaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_model_copy(s : BiostructsecondaryModel) -> BiostructsecondaryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_model_fill(s : BiostructsecondaryModel, v : Double) -> BiostructsecondaryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_model_min(s : BiostructsecondaryModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_model_max(s : BiostructsecondaryModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_model_to_string(s : BiostructsecondaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_layer_make(size : Int) -> BiostructsecondaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_layer_len(s : BiostructsecondaryLayer) -> Int { s.size }

pub fn bio_struct_secondary_layer_get(s : BiostructsecondaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_layer_set(s : BiostructsecondaryLayer, i : Int, v : Double) -> BiostructsecondaryLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_layer_sum(s : BiostructsecondaryLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_layer_mean(s : BiostructsecondaryLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_layer_scale(s : BiostructsecondaryLayer, f : Double) -> BiostructsecondaryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_layer_add(a : BiostructsecondaryLayer, b : BiostructsecondaryLayer) -> BiostructsecondaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_layer_copy(s : BiostructsecondaryLayer) -> BiostructsecondaryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_layer_fill(s : BiostructsecondaryLayer, v : Double) -> BiostructsecondaryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_layer_min(s : BiostructsecondaryLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_layer_max(s : BiostructsecondaryLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_layer_to_string(s : BiostructsecondaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_buffer_make(size : Int) -> BiostructsecondaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_buffer_len(s : BiostructsecondaryBuffer) -> Int { s.size }

pub fn bio_struct_secondary_buffer_get(s : BiostructsecondaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_buffer_set(s : BiostructsecondaryBuffer, i : Int, v : Double) -> BiostructsecondaryBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_buffer_sum(s : BiostructsecondaryBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_buffer_mean(s : BiostructsecondaryBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_buffer_scale(s : BiostructsecondaryBuffer, f : Double) -> BiostructsecondaryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_buffer_add(a : BiostructsecondaryBuffer, b : BiostructsecondaryBuffer) -> BiostructsecondaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_buffer_copy(s : BiostructsecondaryBuffer) -> BiostructsecondaryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_buffer_fill(s : BiostructsecondaryBuffer, v : Double) -> BiostructsecondaryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_buffer_min(s : BiostructsecondaryBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_buffer_max(s : BiostructsecondaryBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_buffer_to_string(s : BiostructsecondaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_cursor_make(size : Int) -> BiostructsecondaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_cursor_len(s : BiostructsecondaryCursor) -> Int { s.size }

pub fn bio_struct_secondary_cursor_get(s : BiostructsecondaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_cursor_set(s : BiostructsecondaryCursor, i : Int, v : Double) -> BiostructsecondaryCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cursor_sum(s : BiostructsecondaryCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_cursor_mean(s : BiostructsecondaryCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_cursor_scale(s : BiostructsecondaryCursor, f : Double) -> BiostructsecondaryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cursor_add(a : BiostructsecondaryCursor, b : BiostructsecondaryCursor) -> BiostructsecondaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_cursor_copy(s : BiostructsecondaryCursor) -> BiostructsecondaryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cursor_fill(s : BiostructsecondaryCursor, v : Double) -> BiostructsecondaryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cursor_min(s : BiostructsecondaryCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_cursor_max(s : BiostructsecondaryCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_cursor_to_string(s : BiostructsecondaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_view_make(size : Int) -> BiostructsecondaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_view_len(s : BiostructsecondaryView) -> Int { s.size }

pub fn bio_struct_secondary_view_get(s : BiostructsecondaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_view_set(s : BiostructsecondaryView, i : Int, v : Double) -> BiostructsecondaryView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_view_sum(s : BiostructsecondaryView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_view_mean(s : BiostructsecondaryView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_view_scale(s : BiostructsecondaryView, f : Double) -> BiostructsecondaryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_view_add(a : BiostructsecondaryView, b : BiostructsecondaryView) -> BiostructsecondaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_view_copy(s : BiostructsecondaryView) -> BiostructsecondaryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_view_fill(s : BiostructsecondaryView, v : Double) -> BiostructsecondaryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_view_min(s : BiostructsecondaryView) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_view_max(s : BiostructsecondaryView) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_view_to_string(s : BiostructsecondaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_range_make(size : Int) -> BiostructsecondaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_range_len(s : BiostructsecondaryRange) -> Int { s.size }

pub fn bio_struct_secondary_range_get(s : BiostructsecondaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_range_set(s : BiostructsecondaryRange, i : Int, v : Double) -> BiostructsecondaryRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_range_sum(s : BiostructsecondaryRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_range_mean(s : BiostructsecondaryRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_range_scale(s : BiostructsecondaryRange, f : Double) -> BiostructsecondaryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_range_add(a : BiostructsecondaryRange, b : BiostructsecondaryRange) -> BiostructsecondaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_range_copy(s : BiostructsecondaryRange) -> BiostructsecondaryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_range_fill(s : BiostructsecondaryRange, v : Double) -> BiostructsecondaryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_range_min(s : BiostructsecondaryRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_range_max(s : BiostructsecondaryRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_range_to_string(s : BiostructsecondaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_slice_make(size : Int) -> BiostructsecondarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_slice_len(s : BiostructsecondarySlice) -> Int { s.size }

pub fn bio_struct_secondary_slice_get(s : BiostructsecondarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_slice_set(s : BiostructsecondarySlice, i : Int, v : Double) -> BiostructsecondarySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_slice_sum(s : BiostructsecondarySlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_slice_mean(s : BiostructsecondarySlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_slice_scale(s : BiostructsecondarySlice, f : Double) -> BiostructsecondarySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_slice_add(a : BiostructsecondarySlice, b : BiostructsecondarySlice) -> BiostructsecondarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_slice_copy(s : BiostructsecondarySlice) -> BiostructsecondarySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_slice_fill(s : BiostructsecondarySlice, v : Double) -> BiostructsecondarySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_slice_min(s : BiostructsecondarySlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_slice_max(s : BiostructsecondarySlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_slice_to_string(s : BiostructsecondarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

