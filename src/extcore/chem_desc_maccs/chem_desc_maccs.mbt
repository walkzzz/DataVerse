///===
/// extcore/chem_desc_maccs

pub(all) struct ChemdescmaccsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_maccs_make_point(x : Double, y : Double) -> ChemdescmaccsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_maccs_make_point3(x : Double, y : Double, z : Double) -> ChemdescmaccsPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescmaccsPoint::x(self : ChemdescmaccsPoint) -> Double { self.x }

pub fn ChemdescmaccsPoint::y(self : ChemdescmaccsPoint) -> Double { self.y }

pub fn ChemdescmaccsPoint::z(self : ChemdescmaccsPoint) -> Double { self.z }

pub fn ChemdescmaccsPoint::label(self : ChemdescmaccsPoint) -> Int { self.label }

pub fn ChemdescmaccsPoint::dist(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescmaccsPoint::add(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescmaccsPoint::sub(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescmaccsPoint::scale(self : ChemdescmaccsPoint, s : Double) -> ChemdescmaccsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescmaccsPoint::dot(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescmaccsPoint::cross(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescmaccsPoint::norm(self : ChemdescmaccsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescmaccsPoint::normalize(self : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescmaccsPoint::negate(self : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescmaccsPoint::mid(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescmaccsPoint::lerp(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint, t : Double) -> ChemdescmaccsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescmaccsPoint::to_string(self : ChemdescmaccsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescmaccsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_maccs_make_series(vals : Array[Double], name : String) -> ChemdescmaccsSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescmaccsSeries::len(self : ChemdescmaccsSeries) -> Int { self.vals.length() }

pub fn ChemdescmaccsSeries::sum(self : ChemdescmaccsSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescmaccsSeries::mean(self : ChemdescmaccsSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescmaccsSeries::min(self : ChemdescmaccsSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescmaccsSeries::max(self : ChemdescmaccsSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescmaccsSeries::range(self : ChemdescmaccsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescmaccsSeries::variance(self : ChemdescmaccsSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescmaccsSeries::std(self : ChemdescmaccsSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescmaccsSeries::median(self : ChemdescmaccsSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescmaccsSeries::scale(self : ChemdescmaccsSeries, f : Double) -> ChemdescmaccsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescmaccsSeries::add(self : ChemdescmaccsSeries, other : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescmaccsSeries::sub(self : ChemdescmaccsSeries, other : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescmaccsSeries::normalize(self : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescmaccsSeries::cumsum(self : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescmaccsSeries::to_string(self : ChemdescmaccsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescmaccsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_maccs_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescmaccsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_maccs_matrix_identity(n : Int) -> ChemdescmaccsMatrix {
  let m = chem_desc_maccs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescmaccsMatrix::get(self : ChemdescmaccsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescmaccsMatrix::transpose(self : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  let result = chem_desc_maccs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescmaccsMatrix::add(self : ChemdescmaccsMatrix, other : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_maccs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescmaccsMatrix::scale(self : ChemdescmaccsMatrix, s : Double) -> ChemdescmaccsMatrix {
  let result = chem_desc_maccs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescmaccsMatrix::multiply(self : ChemdescmaccsMatrix, other : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  if self.cols != other.rows { return chem_desc_maccs_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_maccs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescmaccsMatrix::trace(self : ChemdescmaccsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescmaccsMatrix::det(self : ChemdescmaccsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescmaccsMatrix::norm(self : ChemdescmaccsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescmaccsMatrix::to_string(self : ChemdescmaccsMatrix) -> String {
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

pub(all) struct ChemdescmaccsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_maccs_make_vector(comps : Array[Double]) -> ChemdescmaccsVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_maccs_vector_zero(dim : Int) -> ChemdescmaccsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescmaccsVector::add(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescmaccsVector::sub(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescmaccsVector::scale(self : ChemdescmaccsVector, s : Double) -> ChemdescmaccsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescmaccsVector::dot(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescmaccsVector::norm(self : ChemdescmaccsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescmaccsVector::normalize(self : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescmaccsVector::dist(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescmaccsVector::to_string(self : ChemdescmaccsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_maccs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_maccs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_maccs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_maccs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_maccs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_maccs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_maccs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_maccs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_maccs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_maccs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_maccs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_maccs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_maccs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_maccs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_maccs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_maccs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_maccs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_maccs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_maccs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_maccs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_maccs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_maccs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_maccs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_maccs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_maccs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_maccs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_maccs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_maccs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_maccs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescmaccsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_frame_make(size : Int) -> ChemdescmaccsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_frame_len(s : ChemdescmaccsFrame) -> Int { s.size }

pub fn chem_desc_maccs_frame_get(s : ChemdescmaccsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_frame_set(s : ChemdescmaccsFrame, i : Int, v : Double) -> ChemdescmaccsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_frame_sum(s : ChemdescmaccsFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_frame_mean(s : ChemdescmaccsFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_frame_scale(s : ChemdescmaccsFrame, f : Double) -> ChemdescmaccsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_frame_add(a : ChemdescmaccsFrame, b : ChemdescmaccsFrame) -> ChemdescmaccsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_frame_copy(s : ChemdescmaccsFrame) -> ChemdescmaccsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_frame_fill(s : ChemdescmaccsFrame, v : Double) -> ChemdescmaccsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_frame_min(s : ChemdescmaccsFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_frame_max(s : ChemdescmaccsFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_frame_to_string(s : ChemdescmaccsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_table_make(size : Int) -> ChemdescmaccsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_table_len(s : ChemdescmaccsTable) -> Int { s.size }

pub fn chem_desc_maccs_table_get(s : ChemdescmaccsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_table_set(s : ChemdescmaccsTable, i : Int, v : Double) -> ChemdescmaccsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_table_sum(s : ChemdescmaccsTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_table_mean(s : ChemdescmaccsTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_table_scale(s : ChemdescmaccsTable, f : Double) -> ChemdescmaccsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_table_add(a : ChemdescmaccsTable, b : ChemdescmaccsTable) -> ChemdescmaccsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_table_copy(s : ChemdescmaccsTable) -> ChemdescmaccsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_table_fill(s : ChemdescmaccsTable, v : Double) -> ChemdescmaccsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_table_min(s : ChemdescmaccsTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_table_max(s : ChemdescmaccsTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_table_to_string(s : ChemdescmaccsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_graphn_make(size : Int) -> ChemdescmaccsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_graphn_len(s : ChemdescmaccsGraphN) -> Int { s.size }

pub fn chem_desc_maccs_graphn_get(s : ChemdescmaccsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_graphn_set(s : ChemdescmaccsGraphN, i : Int, v : Double) -> ChemdescmaccsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_graphn_sum(s : ChemdescmaccsGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_graphn_mean(s : ChemdescmaccsGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_graphn_scale(s : ChemdescmaccsGraphN, f : Double) -> ChemdescmaccsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_graphn_add(a : ChemdescmaccsGraphN, b : ChemdescmaccsGraphN) -> ChemdescmaccsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_graphn_copy(s : ChemdescmaccsGraphN) -> ChemdescmaccsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_graphn_fill(s : ChemdescmaccsGraphN, v : Double) -> ChemdescmaccsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_graphn_min(s : ChemdescmaccsGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_graphn_max(s : ChemdescmaccsGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_graphn_to_string(s : ChemdescmaccsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_node_make(size : Int) -> ChemdescmaccsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_node_len(s : ChemdescmaccsNode) -> Int { s.size }

pub fn chem_desc_maccs_node_get(s : ChemdescmaccsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_node_set(s : ChemdescmaccsNode, i : Int, v : Double) -> ChemdescmaccsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_node_sum(s : ChemdescmaccsNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_node_mean(s : ChemdescmaccsNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_node_scale(s : ChemdescmaccsNode, f : Double) -> ChemdescmaccsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_node_add(a : ChemdescmaccsNode, b : ChemdescmaccsNode) -> ChemdescmaccsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_node_copy(s : ChemdescmaccsNode) -> ChemdescmaccsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_node_fill(s : ChemdescmaccsNode, v : Double) -> ChemdescmaccsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_node_min(s : ChemdescmaccsNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_node_max(s : ChemdescmaccsNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_node_to_string(s : ChemdescmaccsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_edge_make(size : Int) -> ChemdescmaccsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_edge_len(s : ChemdescmaccsEdge) -> Int { s.size }

pub fn chem_desc_maccs_edge_get(s : ChemdescmaccsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_edge_set(s : ChemdescmaccsEdge, i : Int, v : Double) -> ChemdescmaccsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_edge_sum(s : ChemdescmaccsEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_edge_mean(s : ChemdescmaccsEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_edge_scale(s : ChemdescmaccsEdge, f : Double) -> ChemdescmaccsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_edge_add(a : ChemdescmaccsEdge, b : ChemdescmaccsEdge) -> ChemdescmaccsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_edge_copy(s : ChemdescmaccsEdge) -> ChemdescmaccsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_edge_fill(s : ChemdescmaccsEdge, v : Double) -> ChemdescmaccsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_edge_min(s : ChemdescmaccsEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_edge_max(s : ChemdescmaccsEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_edge_to_string(s : ChemdescmaccsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_path_make(size : Int) -> ChemdescmaccsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_path_len(s : ChemdescmaccsPath) -> Int { s.size }

pub fn chem_desc_maccs_path_get(s : ChemdescmaccsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_path_set(s : ChemdescmaccsPath, i : Int, v : Double) -> ChemdescmaccsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_path_sum(s : ChemdescmaccsPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_path_mean(s : ChemdescmaccsPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_path_scale(s : ChemdescmaccsPath, f : Double) -> ChemdescmaccsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_path_add(a : ChemdescmaccsPath, b : ChemdescmaccsPath) -> ChemdescmaccsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_path_copy(s : ChemdescmaccsPath) -> ChemdescmaccsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_path_fill(s : ChemdescmaccsPath, v : Double) -> ChemdescmaccsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_path_min(s : ChemdescmaccsPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_path_max(s : ChemdescmaccsPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_path_to_string(s : ChemdescmaccsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_cluster_make(size : Int) -> ChemdescmaccsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_cluster_len(s : ChemdescmaccsCluster) -> Int { s.size }

pub fn chem_desc_maccs_cluster_get(s : ChemdescmaccsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_cluster_set(s : ChemdescmaccsCluster, i : Int, v : Double) -> ChemdescmaccsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cluster_sum(s : ChemdescmaccsCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_cluster_mean(s : ChemdescmaccsCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_cluster_scale(s : ChemdescmaccsCluster, f : Double) -> ChemdescmaccsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cluster_add(a : ChemdescmaccsCluster, b : ChemdescmaccsCluster) -> ChemdescmaccsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_cluster_copy(s : ChemdescmaccsCluster) -> ChemdescmaccsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cluster_fill(s : ChemdescmaccsCluster, v : Double) -> ChemdescmaccsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cluster_min(s : ChemdescmaccsCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_cluster_max(s : ChemdescmaccsCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_cluster_to_string(s : ChemdescmaccsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_model_make(size : Int) -> ChemdescmaccsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_model_len(s : ChemdescmaccsModel) -> Int { s.size }

pub fn chem_desc_maccs_model_get(s : ChemdescmaccsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_model_set(s : ChemdescmaccsModel, i : Int, v : Double) -> ChemdescmaccsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_model_sum(s : ChemdescmaccsModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_model_mean(s : ChemdescmaccsModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_model_scale(s : ChemdescmaccsModel, f : Double) -> ChemdescmaccsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_model_add(a : ChemdescmaccsModel, b : ChemdescmaccsModel) -> ChemdescmaccsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_model_copy(s : ChemdescmaccsModel) -> ChemdescmaccsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_model_fill(s : ChemdescmaccsModel, v : Double) -> ChemdescmaccsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_model_min(s : ChemdescmaccsModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_model_max(s : ChemdescmaccsModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_model_to_string(s : ChemdescmaccsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_layer_make(size : Int) -> ChemdescmaccsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_layer_len(s : ChemdescmaccsLayer) -> Int { s.size }

pub fn chem_desc_maccs_layer_get(s : ChemdescmaccsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_layer_set(s : ChemdescmaccsLayer, i : Int, v : Double) -> ChemdescmaccsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_layer_sum(s : ChemdescmaccsLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_layer_mean(s : ChemdescmaccsLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_layer_scale(s : ChemdescmaccsLayer, f : Double) -> ChemdescmaccsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_layer_add(a : ChemdescmaccsLayer, b : ChemdescmaccsLayer) -> ChemdescmaccsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_layer_copy(s : ChemdescmaccsLayer) -> ChemdescmaccsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_layer_fill(s : ChemdescmaccsLayer, v : Double) -> ChemdescmaccsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_layer_min(s : ChemdescmaccsLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_layer_max(s : ChemdescmaccsLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_layer_to_string(s : ChemdescmaccsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_buffer_make(size : Int) -> ChemdescmaccsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_buffer_len(s : ChemdescmaccsBuffer) -> Int { s.size }

pub fn chem_desc_maccs_buffer_get(s : ChemdescmaccsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_buffer_set(s : ChemdescmaccsBuffer, i : Int, v : Double) -> ChemdescmaccsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_buffer_sum(s : ChemdescmaccsBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_buffer_mean(s : ChemdescmaccsBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_buffer_scale(s : ChemdescmaccsBuffer, f : Double) -> ChemdescmaccsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_buffer_add(a : ChemdescmaccsBuffer, b : ChemdescmaccsBuffer) -> ChemdescmaccsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_buffer_copy(s : ChemdescmaccsBuffer) -> ChemdescmaccsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_buffer_fill(s : ChemdescmaccsBuffer, v : Double) -> ChemdescmaccsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_buffer_min(s : ChemdescmaccsBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_buffer_max(s : ChemdescmaccsBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_buffer_to_string(s : ChemdescmaccsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_cursor_make(size : Int) -> ChemdescmaccsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_cursor_len(s : ChemdescmaccsCursor) -> Int { s.size }

pub fn chem_desc_maccs_cursor_get(s : ChemdescmaccsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_cursor_set(s : ChemdescmaccsCursor, i : Int, v : Double) -> ChemdescmaccsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cursor_sum(s : ChemdescmaccsCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_cursor_mean(s : ChemdescmaccsCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_cursor_scale(s : ChemdescmaccsCursor, f : Double) -> ChemdescmaccsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cursor_add(a : ChemdescmaccsCursor, b : ChemdescmaccsCursor) -> ChemdescmaccsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_cursor_copy(s : ChemdescmaccsCursor) -> ChemdescmaccsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cursor_fill(s : ChemdescmaccsCursor, v : Double) -> ChemdescmaccsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cursor_min(s : ChemdescmaccsCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_cursor_max(s : ChemdescmaccsCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_cursor_to_string(s : ChemdescmaccsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_view_make(size : Int) -> ChemdescmaccsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_view_len(s : ChemdescmaccsView) -> Int { s.size }

pub fn chem_desc_maccs_view_get(s : ChemdescmaccsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_view_set(s : ChemdescmaccsView, i : Int, v : Double) -> ChemdescmaccsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_view_sum(s : ChemdescmaccsView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_view_mean(s : ChemdescmaccsView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_view_scale(s : ChemdescmaccsView, f : Double) -> ChemdescmaccsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_view_add(a : ChemdescmaccsView, b : ChemdescmaccsView) -> ChemdescmaccsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_view_copy(s : ChemdescmaccsView) -> ChemdescmaccsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_view_fill(s : ChemdescmaccsView, v : Double) -> ChemdescmaccsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_view_min(s : ChemdescmaccsView) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_view_max(s : ChemdescmaccsView) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_view_to_string(s : ChemdescmaccsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_range_make(size : Int) -> ChemdescmaccsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_range_len(s : ChemdescmaccsRange) -> Int { s.size }

pub fn chem_desc_maccs_range_get(s : ChemdescmaccsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_range_set(s : ChemdescmaccsRange, i : Int, v : Double) -> ChemdescmaccsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_range_sum(s : ChemdescmaccsRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_range_mean(s : ChemdescmaccsRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_range_scale(s : ChemdescmaccsRange, f : Double) -> ChemdescmaccsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_range_add(a : ChemdescmaccsRange, b : ChemdescmaccsRange) -> ChemdescmaccsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_range_copy(s : ChemdescmaccsRange) -> ChemdescmaccsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_range_fill(s : ChemdescmaccsRange, v : Double) -> ChemdescmaccsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_range_min(s : ChemdescmaccsRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_range_max(s : ChemdescmaccsRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_range_to_string(s : ChemdescmaccsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_slice_make(size : Int) -> ChemdescmaccsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_slice_len(s : ChemdescmaccsSlice) -> Int { s.size }

pub fn chem_desc_maccs_slice_get(s : ChemdescmaccsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_slice_set(s : ChemdescmaccsSlice, i : Int, v : Double) -> ChemdescmaccsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_slice_sum(s : ChemdescmaccsSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_slice_mean(s : ChemdescmaccsSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_slice_scale(s : ChemdescmaccsSlice, f : Double) -> ChemdescmaccsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_slice_add(a : ChemdescmaccsSlice, b : ChemdescmaccsSlice) -> ChemdescmaccsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_slice_copy(s : ChemdescmaccsSlice) -> ChemdescmaccsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_slice_fill(s : ChemdescmaccsSlice, v : Double) -> ChemdescmaccsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_slice_min(s : ChemdescmaccsSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_slice_max(s : ChemdescmaccsSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_slice_to_string(s : ChemdescmaccsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

