///===
/// extcore/chem_desc_geometric

pub(all) struct ChemdescgeometricPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_geometric_make_point(x : Double, y : Double) -> ChemdescgeometricPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_geometric_make_point3(x : Double, y : Double, z : Double) -> ChemdescgeometricPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescgeometricPoint::x(self : ChemdescgeometricPoint) -> Double { self.x }

pub fn ChemdescgeometricPoint::y(self : ChemdescgeometricPoint) -> Double { self.y }

pub fn ChemdescgeometricPoint::z(self : ChemdescgeometricPoint) -> Double { self.z }

pub fn ChemdescgeometricPoint::label(self : ChemdescgeometricPoint) -> Int { self.label }

pub fn ChemdescgeometricPoint::dist(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescgeometricPoint::add(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescgeometricPoint::sub(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescgeometricPoint::scale(self : ChemdescgeometricPoint, s : Double) -> ChemdescgeometricPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescgeometricPoint::dot(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescgeometricPoint::cross(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescgeometricPoint::norm(self : ChemdescgeometricPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescgeometricPoint::normalize(self : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescgeometricPoint::negate(self : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescgeometricPoint::mid(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescgeometricPoint::lerp(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint, t : Double) -> ChemdescgeometricPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescgeometricPoint::to_string(self : ChemdescgeometricPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescgeometricSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_geometric_make_series(vals : Array[Double], name : String) -> ChemdescgeometricSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescgeometricSeries::len(self : ChemdescgeometricSeries) -> Int { self.vals.length() }

pub fn ChemdescgeometricSeries::sum(self : ChemdescgeometricSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescgeometricSeries::mean(self : ChemdescgeometricSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescgeometricSeries::min(self : ChemdescgeometricSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescgeometricSeries::max(self : ChemdescgeometricSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescgeometricSeries::range(self : ChemdescgeometricSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescgeometricSeries::variance(self : ChemdescgeometricSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescgeometricSeries::std(self : ChemdescgeometricSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescgeometricSeries::median(self : ChemdescgeometricSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescgeometricSeries::scale(self : ChemdescgeometricSeries, f : Double) -> ChemdescgeometricSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescgeometricSeries::add(self : ChemdescgeometricSeries, other : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescgeometricSeries::sub(self : ChemdescgeometricSeries, other : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescgeometricSeries::normalize(self : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescgeometricSeries::cumsum(self : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescgeometricSeries::to_string(self : ChemdescgeometricSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescgeometricMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_geometric_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescgeometricMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_geometric_matrix_identity(n : Int) -> ChemdescgeometricMatrix {
  let m = chem_desc_geometric_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescgeometricMatrix::get(self : ChemdescgeometricMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescgeometricMatrix::transpose(self : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  let result = chem_desc_geometric_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescgeometricMatrix::add(self : ChemdescgeometricMatrix, other : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_geometric_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescgeometricMatrix::scale(self : ChemdescgeometricMatrix, s : Double) -> ChemdescgeometricMatrix {
  let result = chem_desc_geometric_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescgeometricMatrix::multiply(self : ChemdescgeometricMatrix, other : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  if self.cols != other.rows { return chem_desc_geometric_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_geometric_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescgeometricMatrix::trace(self : ChemdescgeometricMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescgeometricMatrix::det(self : ChemdescgeometricMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescgeometricMatrix::norm(self : ChemdescgeometricMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescgeometricMatrix::to_string(self : ChemdescgeometricMatrix) -> String {
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

pub(all) struct ChemdescgeometricVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_geometric_make_vector(comps : Array[Double]) -> ChemdescgeometricVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_geometric_vector_zero(dim : Int) -> ChemdescgeometricVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescgeometricVector::add(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescgeometricVector::sub(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescgeometricVector::scale(self : ChemdescgeometricVector, s : Double) -> ChemdescgeometricVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescgeometricVector::dot(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescgeometricVector::norm(self : ChemdescgeometricVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescgeometricVector::normalize(self : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescgeometricVector::dist(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescgeometricVector::to_string(self : ChemdescgeometricVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_geometric_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_geometric_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_geometric_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_geometric_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_geometric_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_geometric_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_geometric_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_geometric_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_geometric_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_geometric_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_geometric_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_geometric_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_geometric_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_geometric_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_geometric_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_geometric_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_geometric_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_geometric_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_geometric_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_geometric_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_geometric_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_geometric_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_geometric_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_geometric_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_geometric_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_geometric_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_geometric_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_geometric_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_geometric_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescgeometricFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_frame_make(size : Int) -> ChemdescgeometricFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_frame_len(s : ChemdescgeometricFrame) -> Int { s.size }

pub fn chem_desc_geometric_frame_get(s : ChemdescgeometricFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_frame_set(s : ChemdescgeometricFrame, i : Int, v : Double) -> ChemdescgeometricFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_frame_sum(s : ChemdescgeometricFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_frame_mean(s : ChemdescgeometricFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_frame_scale(s : ChemdescgeometricFrame, f : Double) -> ChemdescgeometricFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_frame_add(a : ChemdescgeometricFrame, b : ChemdescgeometricFrame) -> ChemdescgeometricFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_frame_copy(s : ChemdescgeometricFrame) -> ChemdescgeometricFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_frame_fill(s : ChemdescgeometricFrame, v : Double) -> ChemdescgeometricFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_frame_min(s : ChemdescgeometricFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_frame_max(s : ChemdescgeometricFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_frame_to_string(s : ChemdescgeometricFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_table_make(size : Int) -> ChemdescgeometricTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_table_len(s : ChemdescgeometricTable) -> Int { s.size }

pub fn chem_desc_geometric_table_get(s : ChemdescgeometricTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_table_set(s : ChemdescgeometricTable, i : Int, v : Double) -> ChemdescgeometricTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_table_sum(s : ChemdescgeometricTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_table_mean(s : ChemdescgeometricTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_table_scale(s : ChemdescgeometricTable, f : Double) -> ChemdescgeometricTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_table_add(a : ChemdescgeometricTable, b : ChemdescgeometricTable) -> ChemdescgeometricTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_table_copy(s : ChemdescgeometricTable) -> ChemdescgeometricTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_table_fill(s : ChemdescgeometricTable, v : Double) -> ChemdescgeometricTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_table_min(s : ChemdescgeometricTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_table_max(s : ChemdescgeometricTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_table_to_string(s : ChemdescgeometricTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_graphn_make(size : Int) -> ChemdescgeometricGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_graphn_len(s : ChemdescgeometricGraphN) -> Int { s.size }

pub fn chem_desc_geometric_graphn_get(s : ChemdescgeometricGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_graphn_set(s : ChemdescgeometricGraphN, i : Int, v : Double) -> ChemdescgeometricGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_graphn_sum(s : ChemdescgeometricGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_graphn_mean(s : ChemdescgeometricGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_graphn_scale(s : ChemdescgeometricGraphN, f : Double) -> ChemdescgeometricGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_graphn_add(a : ChemdescgeometricGraphN, b : ChemdescgeometricGraphN) -> ChemdescgeometricGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_graphn_copy(s : ChemdescgeometricGraphN) -> ChemdescgeometricGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_graphn_fill(s : ChemdescgeometricGraphN, v : Double) -> ChemdescgeometricGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_graphn_min(s : ChemdescgeometricGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_graphn_max(s : ChemdescgeometricGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_graphn_to_string(s : ChemdescgeometricGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_node_make(size : Int) -> ChemdescgeometricNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_node_len(s : ChemdescgeometricNode) -> Int { s.size }

pub fn chem_desc_geometric_node_get(s : ChemdescgeometricNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_node_set(s : ChemdescgeometricNode, i : Int, v : Double) -> ChemdescgeometricNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_node_sum(s : ChemdescgeometricNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_node_mean(s : ChemdescgeometricNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_node_scale(s : ChemdescgeometricNode, f : Double) -> ChemdescgeometricNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_node_add(a : ChemdescgeometricNode, b : ChemdescgeometricNode) -> ChemdescgeometricNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_node_copy(s : ChemdescgeometricNode) -> ChemdescgeometricNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_node_fill(s : ChemdescgeometricNode, v : Double) -> ChemdescgeometricNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_node_min(s : ChemdescgeometricNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_node_max(s : ChemdescgeometricNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_node_to_string(s : ChemdescgeometricNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_edge_make(size : Int) -> ChemdescgeometricEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_edge_len(s : ChemdescgeometricEdge) -> Int { s.size }

pub fn chem_desc_geometric_edge_get(s : ChemdescgeometricEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_edge_set(s : ChemdescgeometricEdge, i : Int, v : Double) -> ChemdescgeometricEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_edge_sum(s : ChemdescgeometricEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_edge_mean(s : ChemdescgeometricEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_edge_scale(s : ChemdescgeometricEdge, f : Double) -> ChemdescgeometricEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_edge_add(a : ChemdescgeometricEdge, b : ChemdescgeometricEdge) -> ChemdescgeometricEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_edge_copy(s : ChemdescgeometricEdge) -> ChemdescgeometricEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_edge_fill(s : ChemdescgeometricEdge, v : Double) -> ChemdescgeometricEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_edge_min(s : ChemdescgeometricEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_edge_max(s : ChemdescgeometricEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_edge_to_string(s : ChemdescgeometricEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_path_make(size : Int) -> ChemdescgeometricPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_path_len(s : ChemdescgeometricPath) -> Int { s.size }

pub fn chem_desc_geometric_path_get(s : ChemdescgeometricPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_path_set(s : ChemdescgeometricPath, i : Int, v : Double) -> ChemdescgeometricPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_path_sum(s : ChemdescgeometricPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_path_mean(s : ChemdescgeometricPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_path_scale(s : ChemdescgeometricPath, f : Double) -> ChemdescgeometricPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_path_add(a : ChemdescgeometricPath, b : ChemdescgeometricPath) -> ChemdescgeometricPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_path_copy(s : ChemdescgeometricPath) -> ChemdescgeometricPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_path_fill(s : ChemdescgeometricPath, v : Double) -> ChemdescgeometricPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_path_min(s : ChemdescgeometricPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_path_max(s : ChemdescgeometricPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_path_to_string(s : ChemdescgeometricPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_cluster_make(size : Int) -> ChemdescgeometricCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_cluster_len(s : ChemdescgeometricCluster) -> Int { s.size }

pub fn chem_desc_geometric_cluster_get(s : ChemdescgeometricCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_cluster_set(s : ChemdescgeometricCluster, i : Int, v : Double) -> ChemdescgeometricCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cluster_sum(s : ChemdescgeometricCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_cluster_mean(s : ChemdescgeometricCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_cluster_scale(s : ChemdescgeometricCluster, f : Double) -> ChemdescgeometricCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cluster_add(a : ChemdescgeometricCluster, b : ChemdescgeometricCluster) -> ChemdescgeometricCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_cluster_copy(s : ChemdescgeometricCluster) -> ChemdescgeometricCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cluster_fill(s : ChemdescgeometricCluster, v : Double) -> ChemdescgeometricCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cluster_min(s : ChemdescgeometricCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_cluster_max(s : ChemdescgeometricCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_cluster_to_string(s : ChemdescgeometricCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_model_make(size : Int) -> ChemdescgeometricModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_model_len(s : ChemdescgeometricModel) -> Int { s.size }

pub fn chem_desc_geometric_model_get(s : ChemdescgeometricModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_model_set(s : ChemdescgeometricModel, i : Int, v : Double) -> ChemdescgeometricModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_model_sum(s : ChemdescgeometricModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_model_mean(s : ChemdescgeometricModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_model_scale(s : ChemdescgeometricModel, f : Double) -> ChemdescgeometricModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_model_add(a : ChemdescgeometricModel, b : ChemdescgeometricModel) -> ChemdescgeometricModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_model_copy(s : ChemdescgeometricModel) -> ChemdescgeometricModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_model_fill(s : ChemdescgeometricModel, v : Double) -> ChemdescgeometricModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_model_min(s : ChemdescgeometricModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_model_max(s : ChemdescgeometricModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_model_to_string(s : ChemdescgeometricModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_layer_make(size : Int) -> ChemdescgeometricLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_layer_len(s : ChemdescgeometricLayer) -> Int { s.size }

pub fn chem_desc_geometric_layer_get(s : ChemdescgeometricLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_layer_set(s : ChemdescgeometricLayer, i : Int, v : Double) -> ChemdescgeometricLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_layer_sum(s : ChemdescgeometricLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_layer_mean(s : ChemdescgeometricLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_layer_scale(s : ChemdescgeometricLayer, f : Double) -> ChemdescgeometricLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_layer_add(a : ChemdescgeometricLayer, b : ChemdescgeometricLayer) -> ChemdescgeometricLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_layer_copy(s : ChemdescgeometricLayer) -> ChemdescgeometricLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_layer_fill(s : ChemdescgeometricLayer, v : Double) -> ChemdescgeometricLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_layer_min(s : ChemdescgeometricLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_layer_max(s : ChemdescgeometricLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_layer_to_string(s : ChemdescgeometricLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_buffer_make(size : Int) -> ChemdescgeometricBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_buffer_len(s : ChemdescgeometricBuffer) -> Int { s.size }

pub fn chem_desc_geometric_buffer_get(s : ChemdescgeometricBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_buffer_set(s : ChemdescgeometricBuffer, i : Int, v : Double) -> ChemdescgeometricBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_buffer_sum(s : ChemdescgeometricBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_buffer_mean(s : ChemdescgeometricBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_buffer_scale(s : ChemdescgeometricBuffer, f : Double) -> ChemdescgeometricBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_buffer_add(a : ChemdescgeometricBuffer, b : ChemdescgeometricBuffer) -> ChemdescgeometricBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_buffer_copy(s : ChemdescgeometricBuffer) -> ChemdescgeometricBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_buffer_fill(s : ChemdescgeometricBuffer, v : Double) -> ChemdescgeometricBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_buffer_min(s : ChemdescgeometricBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_buffer_max(s : ChemdescgeometricBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_buffer_to_string(s : ChemdescgeometricBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_cursor_make(size : Int) -> ChemdescgeometricCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_cursor_len(s : ChemdescgeometricCursor) -> Int { s.size }

pub fn chem_desc_geometric_cursor_get(s : ChemdescgeometricCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_cursor_set(s : ChemdescgeometricCursor, i : Int, v : Double) -> ChemdescgeometricCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cursor_sum(s : ChemdescgeometricCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_cursor_mean(s : ChemdescgeometricCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_cursor_scale(s : ChemdescgeometricCursor, f : Double) -> ChemdescgeometricCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cursor_add(a : ChemdescgeometricCursor, b : ChemdescgeometricCursor) -> ChemdescgeometricCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_cursor_copy(s : ChemdescgeometricCursor) -> ChemdescgeometricCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cursor_fill(s : ChemdescgeometricCursor, v : Double) -> ChemdescgeometricCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_cursor_min(s : ChemdescgeometricCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_cursor_max(s : ChemdescgeometricCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_cursor_to_string(s : ChemdescgeometricCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_view_make(size : Int) -> ChemdescgeometricView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_view_len(s : ChemdescgeometricView) -> Int { s.size }

pub fn chem_desc_geometric_view_get(s : ChemdescgeometricView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_view_set(s : ChemdescgeometricView, i : Int, v : Double) -> ChemdescgeometricView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_view_sum(s : ChemdescgeometricView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_view_mean(s : ChemdescgeometricView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_view_scale(s : ChemdescgeometricView, f : Double) -> ChemdescgeometricView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_view_add(a : ChemdescgeometricView, b : ChemdescgeometricView) -> ChemdescgeometricView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_view_copy(s : ChemdescgeometricView) -> ChemdescgeometricView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_view_fill(s : ChemdescgeometricView, v : Double) -> ChemdescgeometricView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_view_min(s : ChemdescgeometricView) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_view_max(s : ChemdescgeometricView) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_view_to_string(s : ChemdescgeometricView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_range_make(size : Int) -> ChemdescgeometricRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_range_len(s : ChemdescgeometricRange) -> Int { s.size }

pub fn chem_desc_geometric_range_get(s : ChemdescgeometricRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_range_set(s : ChemdescgeometricRange, i : Int, v : Double) -> ChemdescgeometricRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_range_sum(s : ChemdescgeometricRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_range_mean(s : ChemdescgeometricRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_range_scale(s : ChemdescgeometricRange, f : Double) -> ChemdescgeometricRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_range_add(a : ChemdescgeometricRange, b : ChemdescgeometricRange) -> ChemdescgeometricRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_range_copy(s : ChemdescgeometricRange) -> ChemdescgeometricRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_range_fill(s : ChemdescgeometricRange, v : Double) -> ChemdescgeometricRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_range_min(s : ChemdescgeometricRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_range_max(s : ChemdescgeometricRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_range_to_string(s : ChemdescgeometricRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_slice_make(size : Int) -> ChemdescgeometricSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_slice_len(s : ChemdescgeometricSlice) -> Int { s.size }

pub fn chem_desc_geometric_slice_get(s : ChemdescgeometricSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_slice_set(s : ChemdescgeometricSlice, i : Int, v : Double) -> ChemdescgeometricSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_slice_sum(s : ChemdescgeometricSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_geometric_slice_mean(s : ChemdescgeometricSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_geometric_slice_scale(s : ChemdescgeometricSlice, f : Double) -> ChemdescgeometricSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_slice_add(a : ChemdescgeometricSlice, b : ChemdescgeometricSlice) -> ChemdescgeometricSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_geometric_slice_copy(s : ChemdescgeometricSlice) -> ChemdescgeometricSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_slice_fill(s : ChemdescgeometricSlice, v : Double) -> ChemdescgeometricSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_geometric_slice_min(s : ChemdescgeometricSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_geometric_slice_max(s : ChemdescgeometricSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_geometric_slice_to_string(s : ChemdescgeometricSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

