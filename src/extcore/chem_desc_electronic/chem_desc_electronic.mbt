///===
/// extcore/chem_desc_electronic

pub(all) struct ChemdescelectronicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_electronic_make_point(x : Double, y : Double) -> ChemdescelectronicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_electronic_make_point3(x : Double, y : Double, z : Double) -> ChemdescelectronicPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescelectronicPoint::x(self : ChemdescelectronicPoint) -> Double { self.x }

pub fn ChemdescelectronicPoint::y(self : ChemdescelectronicPoint) -> Double { self.y }

pub fn ChemdescelectronicPoint::z(self : ChemdescelectronicPoint) -> Double { self.z }

pub fn ChemdescelectronicPoint::label(self : ChemdescelectronicPoint) -> Int { self.label }

pub fn ChemdescelectronicPoint::dist(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescelectronicPoint::add(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescelectronicPoint::sub(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescelectronicPoint::scale(self : ChemdescelectronicPoint, s : Double) -> ChemdescelectronicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescelectronicPoint::dot(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescelectronicPoint::cross(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescelectronicPoint::norm(self : ChemdescelectronicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescelectronicPoint::normalize(self : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescelectronicPoint::negate(self : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescelectronicPoint::mid(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescelectronicPoint::lerp(self : ChemdescelectronicPoint, other : ChemdescelectronicPoint, t : Double) -> ChemdescelectronicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescelectronicPoint::to_string(self : ChemdescelectronicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescelectronicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_electronic_make_series(vals : Array[Double], name : String) -> ChemdescelectronicSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescelectronicSeries::len(self : ChemdescelectronicSeries) -> Int { self.vals.length() }

pub fn ChemdescelectronicSeries::sum(self : ChemdescelectronicSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescelectronicSeries::mean(self : ChemdescelectronicSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescelectronicSeries::min(self : ChemdescelectronicSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescelectronicSeries::max(self : ChemdescelectronicSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescelectronicSeries::range(self : ChemdescelectronicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescelectronicSeries::variance(self : ChemdescelectronicSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescelectronicSeries::std(self : ChemdescelectronicSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescelectronicSeries::median(self : ChemdescelectronicSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescelectronicSeries::scale(self : ChemdescelectronicSeries, f : Double) -> ChemdescelectronicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescelectronicSeries::add(self : ChemdescelectronicSeries, other : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescelectronicSeries::sub(self : ChemdescelectronicSeries, other : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescelectronicSeries::normalize(self : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescelectronicSeries::cumsum(self : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescelectronicSeries::to_string(self : ChemdescelectronicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescelectronicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_electronic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescelectronicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_electronic_matrix_identity(n : Int) -> ChemdescelectronicMatrix {
  let m = chem_desc_electronic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescelectronicMatrix::get(self : ChemdescelectronicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescelectronicMatrix::transpose(self : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  let result = chem_desc_electronic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescelectronicMatrix::add(self : ChemdescelectronicMatrix, other : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_electronic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescelectronicMatrix::scale(self : ChemdescelectronicMatrix, s : Double) -> ChemdescelectronicMatrix {
  let result = chem_desc_electronic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescelectronicMatrix::multiply(self : ChemdescelectronicMatrix, other : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  if self.cols != other.rows { return chem_desc_electronic_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_electronic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescelectronicMatrix::trace(self : ChemdescelectronicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescelectronicMatrix::det(self : ChemdescelectronicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescelectronicMatrix::norm(self : ChemdescelectronicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescelectronicMatrix::to_string(self : ChemdescelectronicMatrix) -> String {
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

pub(all) struct ChemdescelectronicVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_electronic_make_vector(comps : Array[Double]) -> ChemdescelectronicVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_electronic_vector_zero(dim : Int) -> ChemdescelectronicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescelectronicVector::add(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescelectronicVector::sub(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescelectronicVector::scale(self : ChemdescelectronicVector, s : Double) -> ChemdescelectronicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescelectronicVector::dot(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescelectronicVector::norm(self : ChemdescelectronicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescelectronicVector::normalize(self : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescelectronicVector::dist(self : ChemdescelectronicVector, other : ChemdescelectronicVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescelectronicVector::to_string(self : ChemdescelectronicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_electronic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_electronic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_electronic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_electronic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_electronic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_electronic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_electronic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_electronic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_electronic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_electronic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_electronic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_electronic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_electronic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_electronic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_electronic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_electronic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_electronic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_electronic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_electronic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_electronic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_electronic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_electronic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_electronic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_electronic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_electronic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_electronic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_electronic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_electronic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_electronic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescelectronicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_frame_make(size : Int) -> ChemdescelectronicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_frame_len(s : ChemdescelectronicFrame) -> Int { s.size }

pub fn chem_desc_electronic_frame_get(s : ChemdescelectronicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_frame_set(s : ChemdescelectronicFrame, i : Int, v : Double) -> ChemdescelectronicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_frame_sum(s : ChemdescelectronicFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_frame_mean(s : ChemdescelectronicFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_frame_scale(s : ChemdescelectronicFrame, f : Double) -> ChemdescelectronicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_frame_add(a : ChemdescelectronicFrame, b : ChemdescelectronicFrame) -> ChemdescelectronicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_frame_copy(s : ChemdescelectronicFrame) -> ChemdescelectronicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_frame_fill(s : ChemdescelectronicFrame, v : Double) -> ChemdescelectronicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_frame_min(s : ChemdescelectronicFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_frame_max(s : ChemdescelectronicFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_frame_to_string(s : ChemdescelectronicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_table_make(size : Int) -> ChemdescelectronicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_table_len(s : ChemdescelectronicTable) -> Int { s.size }

pub fn chem_desc_electronic_table_get(s : ChemdescelectronicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_table_set(s : ChemdescelectronicTable, i : Int, v : Double) -> ChemdescelectronicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_table_sum(s : ChemdescelectronicTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_table_mean(s : ChemdescelectronicTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_table_scale(s : ChemdescelectronicTable, f : Double) -> ChemdescelectronicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_table_add(a : ChemdescelectronicTable, b : ChemdescelectronicTable) -> ChemdescelectronicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_table_copy(s : ChemdescelectronicTable) -> ChemdescelectronicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_table_fill(s : ChemdescelectronicTable, v : Double) -> ChemdescelectronicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_table_min(s : ChemdescelectronicTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_table_max(s : ChemdescelectronicTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_table_to_string(s : ChemdescelectronicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_graphn_make(size : Int) -> ChemdescelectronicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_graphn_len(s : ChemdescelectronicGraphN) -> Int { s.size }

pub fn chem_desc_electronic_graphn_get(s : ChemdescelectronicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_graphn_set(s : ChemdescelectronicGraphN, i : Int, v : Double) -> ChemdescelectronicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_graphn_sum(s : ChemdescelectronicGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_graphn_mean(s : ChemdescelectronicGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_graphn_scale(s : ChemdescelectronicGraphN, f : Double) -> ChemdescelectronicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_graphn_add(a : ChemdescelectronicGraphN, b : ChemdescelectronicGraphN) -> ChemdescelectronicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_graphn_copy(s : ChemdescelectronicGraphN) -> ChemdescelectronicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_graphn_fill(s : ChemdescelectronicGraphN, v : Double) -> ChemdescelectronicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_graphn_min(s : ChemdescelectronicGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_graphn_max(s : ChemdescelectronicGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_graphn_to_string(s : ChemdescelectronicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_node_make(size : Int) -> ChemdescelectronicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_node_len(s : ChemdescelectronicNode) -> Int { s.size }

pub fn chem_desc_electronic_node_get(s : ChemdescelectronicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_node_set(s : ChemdescelectronicNode, i : Int, v : Double) -> ChemdescelectronicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_node_sum(s : ChemdescelectronicNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_node_mean(s : ChemdescelectronicNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_node_scale(s : ChemdescelectronicNode, f : Double) -> ChemdescelectronicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_node_add(a : ChemdescelectronicNode, b : ChemdescelectronicNode) -> ChemdescelectronicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_node_copy(s : ChemdescelectronicNode) -> ChemdescelectronicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_node_fill(s : ChemdescelectronicNode, v : Double) -> ChemdescelectronicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_node_min(s : ChemdescelectronicNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_node_max(s : ChemdescelectronicNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_node_to_string(s : ChemdescelectronicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_edge_make(size : Int) -> ChemdescelectronicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_edge_len(s : ChemdescelectronicEdge) -> Int { s.size }

pub fn chem_desc_electronic_edge_get(s : ChemdescelectronicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_edge_set(s : ChemdescelectronicEdge, i : Int, v : Double) -> ChemdescelectronicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_edge_sum(s : ChemdescelectronicEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_edge_mean(s : ChemdescelectronicEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_edge_scale(s : ChemdescelectronicEdge, f : Double) -> ChemdescelectronicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_edge_add(a : ChemdescelectronicEdge, b : ChemdescelectronicEdge) -> ChemdescelectronicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_edge_copy(s : ChemdescelectronicEdge) -> ChemdescelectronicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_edge_fill(s : ChemdescelectronicEdge, v : Double) -> ChemdescelectronicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_edge_min(s : ChemdescelectronicEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_edge_max(s : ChemdescelectronicEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_edge_to_string(s : ChemdescelectronicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_path_make(size : Int) -> ChemdescelectronicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_path_len(s : ChemdescelectronicPath) -> Int { s.size }

pub fn chem_desc_electronic_path_get(s : ChemdescelectronicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_path_set(s : ChemdescelectronicPath, i : Int, v : Double) -> ChemdescelectronicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_path_sum(s : ChemdescelectronicPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_path_mean(s : ChemdescelectronicPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_path_scale(s : ChemdescelectronicPath, f : Double) -> ChemdescelectronicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_path_add(a : ChemdescelectronicPath, b : ChemdescelectronicPath) -> ChemdescelectronicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_path_copy(s : ChemdescelectronicPath) -> ChemdescelectronicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_path_fill(s : ChemdescelectronicPath, v : Double) -> ChemdescelectronicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_path_min(s : ChemdescelectronicPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_path_max(s : ChemdescelectronicPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_path_to_string(s : ChemdescelectronicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_cluster_make(size : Int) -> ChemdescelectronicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_cluster_len(s : ChemdescelectronicCluster) -> Int { s.size }

pub fn chem_desc_electronic_cluster_get(s : ChemdescelectronicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_cluster_set(s : ChemdescelectronicCluster, i : Int, v : Double) -> ChemdescelectronicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cluster_sum(s : ChemdescelectronicCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_cluster_mean(s : ChemdescelectronicCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_cluster_scale(s : ChemdescelectronicCluster, f : Double) -> ChemdescelectronicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cluster_add(a : ChemdescelectronicCluster, b : ChemdescelectronicCluster) -> ChemdescelectronicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_cluster_copy(s : ChemdescelectronicCluster) -> ChemdescelectronicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cluster_fill(s : ChemdescelectronicCluster, v : Double) -> ChemdescelectronicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cluster_min(s : ChemdescelectronicCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_cluster_max(s : ChemdescelectronicCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_cluster_to_string(s : ChemdescelectronicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_model_make(size : Int) -> ChemdescelectronicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_model_len(s : ChemdescelectronicModel) -> Int { s.size }

pub fn chem_desc_electronic_model_get(s : ChemdescelectronicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_model_set(s : ChemdescelectronicModel, i : Int, v : Double) -> ChemdescelectronicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_model_sum(s : ChemdescelectronicModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_model_mean(s : ChemdescelectronicModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_model_scale(s : ChemdescelectronicModel, f : Double) -> ChemdescelectronicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_model_add(a : ChemdescelectronicModel, b : ChemdescelectronicModel) -> ChemdescelectronicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_model_copy(s : ChemdescelectronicModel) -> ChemdescelectronicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_model_fill(s : ChemdescelectronicModel, v : Double) -> ChemdescelectronicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_model_min(s : ChemdescelectronicModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_model_max(s : ChemdescelectronicModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_model_to_string(s : ChemdescelectronicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_layer_make(size : Int) -> ChemdescelectronicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_layer_len(s : ChemdescelectronicLayer) -> Int { s.size }

pub fn chem_desc_electronic_layer_get(s : ChemdescelectronicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_layer_set(s : ChemdescelectronicLayer, i : Int, v : Double) -> ChemdescelectronicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_layer_sum(s : ChemdescelectronicLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_layer_mean(s : ChemdescelectronicLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_layer_scale(s : ChemdescelectronicLayer, f : Double) -> ChemdescelectronicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_layer_add(a : ChemdescelectronicLayer, b : ChemdescelectronicLayer) -> ChemdescelectronicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_layer_copy(s : ChemdescelectronicLayer) -> ChemdescelectronicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_layer_fill(s : ChemdescelectronicLayer, v : Double) -> ChemdescelectronicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_layer_min(s : ChemdescelectronicLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_layer_max(s : ChemdescelectronicLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_layer_to_string(s : ChemdescelectronicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_buffer_make(size : Int) -> ChemdescelectronicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_buffer_len(s : ChemdescelectronicBuffer) -> Int { s.size }

pub fn chem_desc_electronic_buffer_get(s : ChemdescelectronicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_buffer_set(s : ChemdescelectronicBuffer, i : Int, v : Double) -> ChemdescelectronicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_buffer_sum(s : ChemdescelectronicBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_buffer_mean(s : ChemdescelectronicBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_buffer_scale(s : ChemdescelectronicBuffer, f : Double) -> ChemdescelectronicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_buffer_add(a : ChemdescelectronicBuffer, b : ChemdescelectronicBuffer) -> ChemdescelectronicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_buffer_copy(s : ChemdescelectronicBuffer) -> ChemdescelectronicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_buffer_fill(s : ChemdescelectronicBuffer, v : Double) -> ChemdescelectronicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_buffer_min(s : ChemdescelectronicBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_buffer_max(s : ChemdescelectronicBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_buffer_to_string(s : ChemdescelectronicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_cursor_make(size : Int) -> ChemdescelectronicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_cursor_len(s : ChemdescelectronicCursor) -> Int { s.size }

pub fn chem_desc_electronic_cursor_get(s : ChemdescelectronicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_cursor_set(s : ChemdescelectronicCursor, i : Int, v : Double) -> ChemdescelectronicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cursor_sum(s : ChemdescelectronicCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_cursor_mean(s : ChemdescelectronicCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_cursor_scale(s : ChemdescelectronicCursor, f : Double) -> ChemdescelectronicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cursor_add(a : ChemdescelectronicCursor, b : ChemdescelectronicCursor) -> ChemdescelectronicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_cursor_copy(s : ChemdescelectronicCursor) -> ChemdescelectronicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cursor_fill(s : ChemdescelectronicCursor, v : Double) -> ChemdescelectronicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_cursor_min(s : ChemdescelectronicCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_cursor_max(s : ChemdescelectronicCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_cursor_to_string(s : ChemdescelectronicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_view_make(size : Int) -> ChemdescelectronicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_view_len(s : ChemdescelectronicView) -> Int { s.size }

pub fn chem_desc_electronic_view_get(s : ChemdescelectronicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_view_set(s : ChemdescelectronicView, i : Int, v : Double) -> ChemdescelectronicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_view_sum(s : ChemdescelectronicView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_view_mean(s : ChemdescelectronicView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_view_scale(s : ChemdescelectronicView, f : Double) -> ChemdescelectronicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_view_add(a : ChemdescelectronicView, b : ChemdescelectronicView) -> ChemdescelectronicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_view_copy(s : ChemdescelectronicView) -> ChemdescelectronicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_view_fill(s : ChemdescelectronicView, v : Double) -> ChemdescelectronicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_view_min(s : ChemdescelectronicView) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_view_max(s : ChemdescelectronicView) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_view_to_string(s : ChemdescelectronicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_range_make(size : Int) -> ChemdescelectronicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_range_len(s : ChemdescelectronicRange) -> Int { s.size }

pub fn chem_desc_electronic_range_get(s : ChemdescelectronicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_range_set(s : ChemdescelectronicRange, i : Int, v : Double) -> ChemdescelectronicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_range_sum(s : ChemdescelectronicRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_range_mean(s : ChemdescelectronicRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_range_scale(s : ChemdescelectronicRange, f : Double) -> ChemdescelectronicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_range_add(a : ChemdescelectronicRange, b : ChemdescelectronicRange) -> ChemdescelectronicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_range_copy(s : ChemdescelectronicRange) -> ChemdescelectronicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_range_fill(s : ChemdescelectronicRange, v : Double) -> ChemdescelectronicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_range_min(s : ChemdescelectronicRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_range_max(s : ChemdescelectronicRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_range_to_string(s : ChemdescelectronicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_slice_make(size : Int) -> ChemdescelectronicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_slice_len(s : ChemdescelectronicSlice) -> Int { s.size }

pub fn chem_desc_electronic_slice_get(s : ChemdescelectronicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_slice_set(s : ChemdescelectronicSlice, i : Int, v : Double) -> ChemdescelectronicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_slice_sum(s : ChemdescelectronicSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_slice_mean(s : ChemdescelectronicSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_slice_scale(s : ChemdescelectronicSlice, f : Double) -> ChemdescelectronicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_slice_add(a : ChemdescelectronicSlice, b : ChemdescelectronicSlice) -> ChemdescelectronicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_electronic_slice_copy(s : ChemdescelectronicSlice) -> ChemdescelectronicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_slice_fill(s : ChemdescelectronicSlice, v : Double) -> ChemdescelectronicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_electronic_slice_min(s : ChemdescelectronicSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_slice_max(s : ChemdescelectronicSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_slice_to_string(s : ChemdescelectronicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

