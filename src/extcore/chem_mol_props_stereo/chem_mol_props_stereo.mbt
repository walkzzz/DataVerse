///===
/// extcore/chem_mol_props_stereo

pub(all) struct ChemmolpropsstereoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_stereo_make_point(x : Double, y : Double) -> ChemmolpropsstereoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_stereo_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsstereoPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsstereoPoint::x(self : ChemmolpropsstereoPoint) -> Double { self.x }

pub fn ChemmolpropsstereoPoint::y(self : ChemmolpropsstereoPoint) -> Double { self.y }

pub fn ChemmolpropsstereoPoint::z(self : ChemmolpropsstereoPoint) -> Double { self.z }

pub fn ChemmolpropsstereoPoint::label(self : ChemmolpropsstereoPoint) -> Int { self.label }

pub fn ChemmolpropsstereoPoint::dist(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsstereoPoint::add(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsstereoPoint::sub(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsstereoPoint::scale(self : ChemmolpropsstereoPoint, s : Double) -> ChemmolpropsstereoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsstereoPoint::dot(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsstereoPoint::cross(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsstereoPoint::norm(self : ChemmolpropsstereoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsstereoPoint::normalize(self : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsstereoPoint::negate(self : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsstereoPoint::mid(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsstereoPoint::lerp(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint, t : Double) -> ChemmolpropsstereoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsstereoPoint::to_string(self : ChemmolpropsstereoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_stereo_make_series(vals : Array[Double], name : String) -> ChemmolpropsstereoSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsstereoSeries::len(self : ChemmolpropsstereoSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsstereoSeries::sum(self : ChemmolpropsstereoSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsstereoSeries::mean(self : ChemmolpropsstereoSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsstereoSeries::min(self : ChemmolpropsstereoSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsstereoSeries::max(self : ChemmolpropsstereoSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsstereoSeries::range(self : ChemmolpropsstereoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsstereoSeries::variance(self : ChemmolpropsstereoSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsstereoSeries::std(self : ChemmolpropsstereoSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsstereoSeries::median(self : ChemmolpropsstereoSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsstereoSeries::scale(self : ChemmolpropsstereoSeries, f : Double) -> ChemmolpropsstereoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::add(self : ChemmolpropsstereoSeries, other : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::sub(self : ChemmolpropsstereoSeries, other : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::normalize(self : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsstereoSeries::cumsum(self : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::to_string(self : ChemmolpropsstereoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsstereoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_stereo_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsstereoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_stereo_matrix_identity(n : Int) -> ChemmolpropsstereoMatrix {
  let m = chem_mol_props_stereo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsstereoMatrix::get(self : ChemmolpropsstereoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsstereoMatrix::transpose(self : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  let result = chem_mol_props_stereo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsstereoMatrix::add(self : ChemmolpropsstereoMatrix, other : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_stereo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsstereoMatrix::scale(self : ChemmolpropsstereoMatrix, s : Double) -> ChemmolpropsstereoMatrix {
  let result = chem_mol_props_stereo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsstereoMatrix::multiply(self : ChemmolpropsstereoMatrix, other : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  if self.cols != other.rows { return chem_mol_props_stereo_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_stereo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropsstereoMatrix::trace(self : ChemmolpropsstereoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsstereoMatrix::det(self : ChemmolpropsstereoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsstereoMatrix::norm(self : ChemmolpropsstereoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsstereoMatrix::to_string(self : ChemmolpropsstereoMatrix) -> String {
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

pub(all) struct ChemmolpropsstereoVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_stereo_make_vector(comps : Array[Double]) -> ChemmolpropsstereoVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_stereo_vector_zero(dim : Int) -> ChemmolpropsstereoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsstereoVector::add(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsstereoVector::sub(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsstereoVector::scale(self : ChemmolpropsstereoVector, s : Double) -> ChemmolpropsstereoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsstereoVector::dot(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsstereoVector::norm(self : ChemmolpropsstereoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsstereoVector::normalize(self : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsstereoVector::dist(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsstereoVector::to_string(self : ChemmolpropsstereoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_stereo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_stereo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_stereo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_stereo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_stereo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_stereo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_stereo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_stereo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_stereo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_stereo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_stereo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_stereo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_stereo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_stereo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_stereo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_stereo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_stereo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_stereo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_stereo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_stereo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_stereo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_stereo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_stereo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_stereo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_stereo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_stereo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_stereo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_stereo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_stereo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsstereoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_frame_make(size : Int) -> ChemmolpropsstereoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_frame_len(s : ChemmolpropsstereoFrame) -> Int { s.size }

pub fn chem_mol_props_stereo_frame_get(s : ChemmolpropsstereoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_frame_set(s : ChemmolpropsstereoFrame, i : Int, v : Double) -> ChemmolpropsstereoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_frame_sum(s : ChemmolpropsstereoFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_frame_mean(s : ChemmolpropsstereoFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_frame_scale(s : ChemmolpropsstereoFrame, f : Double) -> ChemmolpropsstereoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_frame_add(a : ChemmolpropsstereoFrame, b : ChemmolpropsstereoFrame) -> ChemmolpropsstereoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_frame_copy(s : ChemmolpropsstereoFrame) -> ChemmolpropsstereoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_frame_fill(s : ChemmolpropsstereoFrame, v : Double) -> ChemmolpropsstereoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_frame_min(s : ChemmolpropsstereoFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_frame_max(s : ChemmolpropsstereoFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_frame_to_string(s : ChemmolpropsstereoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_table_make(size : Int) -> ChemmolpropsstereoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_table_len(s : ChemmolpropsstereoTable) -> Int { s.size }

pub fn chem_mol_props_stereo_table_get(s : ChemmolpropsstereoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_table_set(s : ChemmolpropsstereoTable, i : Int, v : Double) -> ChemmolpropsstereoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_table_sum(s : ChemmolpropsstereoTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_table_mean(s : ChemmolpropsstereoTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_table_scale(s : ChemmolpropsstereoTable, f : Double) -> ChemmolpropsstereoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_table_add(a : ChemmolpropsstereoTable, b : ChemmolpropsstereoTable) -> ChemmolpropsstereoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_table_copy(s : ChemmolpropsstereoTable) -> ChemmolpropsstereoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_table_fill(s : ChemmolpropsstereoTable, v : Double) -> ChemmolpropsstereoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_table_min(s : ChemmolpropsstereoTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_table_max(s : ChemmolpropsstereoTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_table_to_string(s : ChemmolpropsstereoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_graphn_make(size : Int) -> ChemmolpropsstereoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_graphn_len(s : ChemmolpropsstereoGraphN) -> Int { s.size }

pub fn chem_mol_props_stereo_graphn_get(s : ChemmolpropsstereoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_graphn_set(s : ChemmolpropsstereoGraphN, i : Int, v : Double) -> ChemmolpropsstereoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_graphn_sum(s : ChemmolpropsstereoGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_graphn_mean(s : ChemmolpropsstereoGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_graphn_scale(s : ChemmolpropsstereoGraphN, f : Double) -> ChemmolpropsstereoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_graphn_add(a : ChemmolpropsstereoGraphN, b : ChemmolpropsstereoGraphN) -> ChemmolpropsstereoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_graphn_copy(s : ChemmolpropsstereoGraphN) -> ChemmolpropsstereoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_graphn_fill(s : ChemmolpropsstereoGraphN, v : Double) -> ChemmolpropsstereoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_graphn_min(s : ChemmolpropsstereoGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_graphn_max(s : ChemmolpropsstereoGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_graphn_to_string(s : ChemmolpropsstereoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_node_make(size : Int) -> ChemmolpropsstereoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_node_len(s : ChemmolpropsstereoNode) -> Int { s.size }

pub fn chem_mol_props_stereo_node_get(s : ChemmolpropsstereoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_node_set(s : ChemmolpropsstereoNode, i : Int, v : Double) -> ChemmolpropsstereoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_node_sum(s : ChemmolpropsstereoNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_node_mean(s : ChemmolpropsstereoNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_node_scale(s : ChemmolpropsstereoNode, f : Double) -> ChemmolpropsstereoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_node_add(a : ChemmolpropsstereoNode, b : ChemmolpropsstereoNode) -> ChemmolpropsstereoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_node_copy(s : ChemmolpropsstereoNode) -> ChemmolpropsstereoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_node_fill(s : ChemmolpropsstereoNode, v : Double) -> ChemmolpropsstereoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_node_min(s : ChemmolpropsstereoNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_node_max(s : ChemmolpropsstereoNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_node_to_string(s : ChemmolpropsstereoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_edge_make(size : Int) -> ChemmolpropsstereoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_edge_len(s : ChemmolpropsstereoEdge) -> Int { s.size }

pub fn chem_mol_props_stereo_edge_get(s : ChemmolpropsstereoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_edge_set(s : ChemmolpropsstereoEdge, i : Int, v : Double) -> ChemmolpropsstereoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_edge_sum(s : ChemmolpropsstereoEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_edge_mean(s : ChemmolpropsstereoEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_edge_scale(s : ChemmolpropsstereoEdge, f : Double) -> ChemmolpropsstereoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_edge_add(a : ChemmolpropsstereoEdge, b : ChemmolpropsstereoEdge) -> ChemmolpropsstereoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_edge_copy(s : ChemmolpropsstereoEdge) -> ChemmolpropsstereoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_edge_fill(s : ChemmolpropsstereoEdge, v : Double) -> ChemmolpropsstereoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_edge_min(s : ChemmolpropsstereoEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_edge_max(s : ChemmolpropsstereoEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_edge_to_string(s : ChemmolpropsstereoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_path_make(size : Int) -> ChemmolpropsstereoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_path_len(s : ChemmolpropsstereoPath) -> Int { s.size }

pub fn chem_mol_props_stereo_path_get(s : ChemmolpropsstereoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_path_set(s : ChemmolpropsstereoPath, i : Int, v : Double) -> ChemmolpropsstereoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_path_sum(s : ChemmolpropsstereoPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_path_mean(s : ChemmolpropsstereoPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_path_scale(s : ChemmolpropsstereoPath, f : Double) -> ChemmolpropsstereoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_path_add(a : ChemmolpropsstereoPath, b : ChemmolpropsstereoPath) -> ChemmolpropsstereoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_path_copy(s : ChemmolpropsstereoPath) -> ChemmolpropsstereoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_path_fill(s : ChemmolpropsstereoPath, v : Double) -> ChemmolpropsstereoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_path_min(s : ChemmolpropsstereoPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_path_max(s : ChemmolpropsstereoPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_path_to_string(s : ChemmolpropsstereoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_cluster_make(size : Int) -> ChemmolpropsstereoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_cluster_len(s : ChemmolpropsstereoCluster) -> Int { s.size }

pub fn chem_mol_props_stereo_cluster_get(s : ChemmolpropsstereoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_cluster_set(s : ChemmolpropsstereoCluster, i : Int, v : Double) -> ChemmolpropsstereoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cluster_sum(s : ChemmolpropsstereoCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_cluster_mean(s : ChemmolpropsstereoCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_cluster_scale(s : ChemmolpropsstereoCluster, f : Double) -> ChemmolpropsstereoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cluster_add(a : ChemmolpropsstereoCluster, b : ChemmolpropsstereoCluster) -> ChemmolpropsstereoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_cluster_copy(s : ChemmolpropsstereoCluster) -> ChemmolpropsstereoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cluster_fill(s : ChemmolpropsstereoCluster, v : Double) -> ChemmolpropsstereoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cluster_min(s : ChemmolpropsstereoCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_cluster_max(s : ChemmolpropsstereoCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_cluster_to_string(s : ChemmolpropsstereoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_model_make(size : Int) -> ChemmolpropsstereoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_model_len(s : ChemmolpropsstereoModel) -> Int { s.size }

pub fn chem_mol_props_stereo_model_get(s : ChemmolpropsstereoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_model_set(s : ChemmolpropsstereoModel, i : Int, v : Double) -> ChemmolpropsstereoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_model_sum(s : ChemmolpropsstereoModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_model_mean(s : ChemmolpropsstereoModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_model_scale(s : ChemmolpropsstereoModel, f : Double) -> ChemmolpropsstereoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_model_add(a : ChemmolpropsstereoModel, b : ChemmolpropsstereoModel) -> ChemmolpropsstereoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_model_copy(s : ChemmolpropsstereoModel) -> ChemmolpropsstereoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_model_fill(s : ChemmolpropsstereoModel, v : Double) -> ChemmolpropsstereoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_model_min(s : ChemmolpropsstereoModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_model_max(s : ChemmolpropsstereoModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_model_to_string(s : ChemmolpropsstereoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_layer_make(size : Int) -> ChemmolpropsstereoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_layer_len(s : ChemmolpropsstereoLayer) -> Int { s.size }

pub fn chem_mol_props_stereo_layer_get(s : ChemmolpropsstereoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_layer_set(s : ChemmolpropsstereoLayer, i : Int, v : Double) -> ChemmolpropsstereoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_layer_sum(s : ChemmolpropsstereoLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_layer_mean(s : ChemmolpropsstereoLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_layer_scale(s : ChemmolpropsstereoLayer, f : Double) -> ChemmolpropsstereoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_layer_add(a : ChemmolpropsstereoLayer, b : ChemmolpropsstereoLayer) -> ChemmolpropsstereoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_layer_copy(s : ChemmolpropsstereoLayer) -> ChemmolpropsstereoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_layer_fill(s : ChemmolpropsstereoLayer, v : Double) -> ChemmolpropsstereoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_layer_min(s : ChemmolpropsstereoLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_layer_max(s : ChemmolpropsstereoLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_layer_to_string(s : ChemmolpropsstereoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_buffer_make(size : Int) -> ChemmolpropsstereoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_buffer_len(s : ChemmolpropsstereoBuffer) -> Int { s.size }

pub fn chem_mol_props_stereo_buffer_get(s : ChemmolpropsstereoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_buffer_set(s : ChemmolpropsstereoBuffer, i : Int, v : Double) -> ChemmolpropsstereoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_buffer_sum(s : ChemmolpropsstereoBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_buffer_mean(s : ChemmolpropsstereoBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_buffer_scale(s : ChemmolpropsstereoBuffer, f : Double) -> ChemmolpropsstereoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_buffer_add(a : ChemmolpropsstereoBuffer, b : ChemmolpropsstereoBuffer) -> ChemmolpropsstereoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_buffer_copy(s : ChemmolpropsstereoBuffer) -> ChemmolpropsstereoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_buffer_fill(s : ChemmolpropsstereoBuffer, v : Double) -> ChemmolpropsstereoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_buffer_min(s : ChemmolpropsstereoBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_buffer_max(s : ChemmolpropsstereoBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_buffer_to_string(s : ChemmolpropsstereoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_cursor_make(size : Int) -> ChemmolpropsstereoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_cursor_len(s : ChemmolpropsstereoCursor) -> Int { s.size }

pub fn chem_mol_props_stereo_cursor_get(s : ChemmolpropsstereoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_cursor_set(s : ChemmolpropsstereoCursor, i : Int, v : Double) -> ChemmolpropsstereoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cursor_sum(s : ChemmolpropsstereoCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_cursor_mean(s : ChemmolpropsstereoCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_cursor_scale(s : ChemmolpropsstereoCursor, f : Double) -> ChemmolpropsstereoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cursor_add(a : ChemmolpropsstereoCursor, b : ChemmolpropsstereoCursor) -> ChemmolpropsstereoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_cursor_copy(s : ChemmolpropsstereoCursor) -> ChemmolpropsstereoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cursor_fill(s : ChemmolpropsstereoCursor, v : Double) -> ChemmolpropsstereoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_cursor_min(s : ChemmolpropsstereoCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_cursor_max(s : ChemmolpropsstereoCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_cursor_to_string(s : ChemmolpropsstereoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_view_make(size : Int) -> ChemmolpropsstereoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_view_len(s : ChemmolpropsstereoView) -> Int { s.size }

pub fn chem_mol_props_stereo_view_get(s : ChemmolpropsstereoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_view_set(s : ChemmolpropsstereoView, i : Int, v : Double) -> ChemmolpropsstereoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_view_sum(s : ChemmolpropsstereoView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_view_mean(s : ChemmolpropsstereoView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_view_scale(s : ChemmolpropsstereoView, f : Double) -> ChemmolpropsstereoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_view_add(a : ChemmolpropsstereoView, b : ChemmolpropsstereoView) -> ChemmolpropsstereoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_view_copy(s : ChemmolpropsstereoView) -> ChemmolpropsstereoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_view_fill(s : ChemmolpropsstereoView, v : Double) -> ChemmolpropsstereoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_view_min(s : ChemmolpropsstereoView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_view_max(s : ChemmolpropsstereoView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_view_to_string(s : ChemmolpropsstereoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_range_make(size : Int) -> ChemmolpropsstereoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_range_len(s : ChemmolpropsstereoRange) -> Int { s.size }

pub fn chem_mol_props_stereo_range_get(s : ChemmolpropsstereoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_range_set(s : ChemmolpropsstereoRange, i : Int, v : Double) -> ChemmolpropsstereoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_range_sum(s : ChemmolpropsstereoRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_range_mean(s : ChemmolpropsstereoRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_range_scale(s : ChemmolpropsstereoRange, f : Double) -> ChemmolpropsstereoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_range_add(a : ChemmolpropsstereoRange, b : ChemmolpropsstereoRange) -> ChemmolpropsstereoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_range_copy(s : ChemmolpropsstereoRange) -> ChemmolpropsstereoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_range_fill(s : ChemmolpropsstereoRange, v : Double) -> ChemmolpropsstereoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_range_min(s : ChemmolpropsstereoRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_range_max(s : ChemmolpropsstereoRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_range_to_string(s : ChemmolpropsstereoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_slice_make(size : Int) -> ChemmolpropsstereoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_slice_len(s : ChemmolpropsstereoSlice) -> Int { s.size }

pub fn chem_mol_props_stereo_slice_get(s : ChemmolpropsstereoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_slice_set(s : ChemmolpropsstereoSlice, i : Int, v : Double) -> ChemmolpropsstereoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_slice_sum(s : ChemmolpropsstereoSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_stereo_slice_mean(s : ChemmolpropsstereoSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_stereo_slice_scale(s : ChemmolpropsstereoSlice, f : Double) -> ChemmolpropsstereoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_slice_add(a : ChemmolpropsstereoSlice, b : ChemmolpropsstereoSlice) -> ChemmolpropsstereoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_stereo_slice_copy(s : ChemmolpropsstereoSlice) -> ChemmolpropsstereoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_slice_fill(s : ChemmolpropsstereoSlice, v : Double) -> ChemmolpropsstereoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_stereo_slice_min(s : ChemmolpropsstereoSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_stereo_slice_max(s : ChemmolpropsstereoSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_stereo_slice_to_string(s : ChemmolpropsstereoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

