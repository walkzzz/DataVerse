///===
/// extcore/chem_rxn_mechanism

pub(all) struct ChemrxnmechanismPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_mechanism_make_point(x : Double, y : Double) -> ChemrxnmechanismPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_mechanism_make_point3(x : Double, y : Double, z : Double) -> ChemrxnmechanismPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnmechanismPoint::x(self : ChemrxnmechanismPoint) -> Double { self.x }

pub fn ChemrxnmechanismPoint::y(self : ChemrxnmechanismPoint) -> Double { self.y }

pub fn ChemrxnmechanismPoint::z(self : ChemrxnmechanismPoint) -> Double { self.z }

pub fn ChemrxnmechanismPoint::label(self : ChemrxnmechanismPoint) -> Int { self.label }

pub fn ChemrxnmechanismPoint::dist(self : ChemrxnmechanismPoint, other : ChemrxnmechanismPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnmechanismPoint::add(self : ChemrxnmechanismPoint, other : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnmechanismPoint::sub(self : ChemrxnmechanismPoint, other : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnmechanismPoint::scale(self : ChemrxnmechanismPoint, s : Double) -> ChemrxnmechanismPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnmechanismPoint::dot(self : ChemrxnmechanismPoint, other : ChemrxnmechanismPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnmechanismPoint::cross(self : ChemrxnmechanismPoint, other : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnmechanismPoint::norm(self : ChemrxnmechanismPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnmechanismPoint::normalize(self : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnmechanismPoint::negate(self : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnmechanismPoint::mid(self : ChemrxnmechanismPoint, other : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnmechanismPoint::lerp(self : ChemrxnmechanismPoint, other : ChemrxnmechanismPoint, t : Double) -> ChemrxnmechanismPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnmechanismPoint::to_string(self : ChemrxnmechanismPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnmechanismSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_mechanism_make_series(vals : Array[Double], name : String) -> ChemrxnmechanismSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnmechanismSeries::len(self : ChemrxnmechanismSeries) -> Int { self.vals.length() }

pub fn ChemrxnmechanismSeries::sum(self : ChemrxnmechanismSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnmechanismSeries::mean(self : ChemrxnmechanismSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnmechanismSeries::min(self : ChemrxnmechanismSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnmechanismSeries::max(self : ChemrxnmechanismSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnmechanismSeries::range(self : ChemrxnmechanismSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnmechanismSeries::variance(self : ChemrxnmechanismSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnmechanismSeries::std(self : ChemrxnmechanismSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnmechanismSeries::median(self : ChemrxnmechanismSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnmechanismSeries::scale(self : ChemrxnmechanismSeries, f : Double) -> ChemrxnmechanismSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnmechanismSeries::add(self : ChemrxnmechanismSeries, other : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnmechanismSeries::sub(self : ChemrxnmechanismSeries, other : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnmechanismSeries::normalize(self : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnmechanismSeries::cumsum(self : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnmechanismSeries::to_string(self : ChemrxnmechanismSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnmechanismMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_mechanism_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnmechanismMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_mechanism_matrix_identity(n : Int) -> ChemrxnmechanismMatrix {
  let m = chem_rxn_mechanism_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnmechanismMatrix::get(self : ChemrxnmechanismMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnmechanismMatrix::transpose(self : ChemrxnmechanismMatrix) -> ChemrxnmechanismMatrix {
  let result = chem_rxn_mechanism_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnmechanismMatrix::add(self : ChemrxnmechanismMatrix, other : ChemrxnmechanismMatrix) -> ChemrxnmechanismMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_mechanism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnmechanismMatrix::scale(self : ChemrxnmechanismMatrix, s : Double) -> ChemrxnmechanismMatrix {
  let result = chem_rxn_mechanism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnmechanismMatrix::multiply(self : ChemrxnmechanismMatrix, other : ChemrxnmechanismMatrix) -> ChemrxnmechanismMatrix {
  if self.cols != other.rows { return chem_rxn_mechanism_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_mechanism_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnmechanismMatrix::trace(self : ChemrxnmechanismMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnmechanismMatrix::det(self : ChemrxnmechanismMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnmechanismMatrix::norm(self : ChemrxnmechanismMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnmechanismMatrix::to_string(self : ChemrxnmechanismMatrix) -> String {
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

pub(all) struct ChemrxnmechanismVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_mechanism_make_vector(comps : Array[Double]) -> ChemrxnmechanismVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_mechanism_vector_zero(dim : Int) -> ChemrxnmechanismVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnmechanismVector::add(self : ChemrxnmechanismVector, other : ChemrxnmechanismVector) -> ChemrxnmechanismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnmechanismVector::sub(self : ChemrxnmechanismVector, other : ChemrxnmechanismVector) -> ChemrxnmechanismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnmechanismVector::scale(self : ChemrxnmechanismVector, s : Double) -> ChemrxnmechanismVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnmechanismVector::dot(self : ChemrxnmechanismVector, other : ChemrxnmechanismVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnmechanismVector::norm(self : ChemrxnmechanismVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnmechanismVector::normalize(self : ChemrxnmechanismVector) -> ChemrxnmechanismVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnmechanismVector::dist(self : ChemrxnmechanismVector, other : ChemrxnmechanismVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnmechanismVector::to_string(self : ChemrxnmechanismVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_mechanism_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_mechanism_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_mechanism_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_mechanism_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_mechanism_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_mechanism_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_mechanism_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_mechanism_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_mechanism_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_mechanism_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_mechanism_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_mechanism_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_mechanism_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_mechanism_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_mechanism_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_mechanism_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_mechanism_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_mechanism_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_mechanism_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_mechanism_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_mechanism_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_mechanism_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_mechanism_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_mechanism_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_mechanism_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_mechanism_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_mechanism_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_mechanism_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_mechanism_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnmechanismFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_frame_make(size : Int) -> ChemrxnmechanismFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_frame_len(s : ChemrxnmechanismFrame) -> Int { s.size }

pub fn chem_rxn_mechanism_frame_get(s : ChemrxnmechanismFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_frame_set(s : ChemrxnmechanismFrame, i : Int, v : Double) -> ChemrxnmechanismFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_frame_sum(s : ChemrxnmechanismFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_frame_mean(s : ChemrxnmechanismFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_frame_scale(s : ChemrxnmechanismFrame, f : Double) -> ChemrxnmechanismFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_frame_add(a : ChemrxnmechanismFrame, b : ChemrxnmechanismFrame) -> ChemrxnmechanismFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_frame_copy(s : ChemrxnmechanismFrame) -> ChemrxnmechanismFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_frame_fill(s : ChemrxnmechanismFrame, v : Double) -> ChemrxnmechanismFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_frame_min(s : ChemrxnmechanismFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_frame_max(s : ChemrxnmechanismFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_frame_to_string(s : ChemrxnmechanismFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_table_make(size : Int) -> ChemrxnmechanismTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_table_len(s : ChemrxnmechanismTable) -> Int { s.size }

pub fn chem_rxn_mechanism_table_get(s : ChemrxnmechanismTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_table_set(s : ChemrxnmechanismTable, i : Int, v : Double) -> ChemrxnmechanismTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_table_sum(s : ChemrxnmechanismTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_table_mean(s : ChemrxnmechanismTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_table_scale(s : ChemrxnmechanismTable, f : Double) -> ChemrxnmechanismTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_table_add(a : ChemrxnmechanismTable, b : ChemrxnmechanismTable) -> ChemrxnmechanismTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_table_copy(s : ChemrxnmechanismTable) -> ChemrxnmechanismTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_table_fill(s : ChemrxnmechanismTable, v : Double) -> ChemrxnmechanismTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_table_min(s : ChemrxnmechanismTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_table_max(s : ChemrxnmechanismTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_table_to_string(s : ChemrxnmechanismTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_graphn_make(size : Int) -> ChemrxnmechanismGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_graphn_len(s : ChemrxnmechanismGraphN) -> Int { s.size }

pub fn chem_rxn_mechanism_graphn_get(s : ChemrxnmechanismGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_graphn_set(s : ChemrxnmechanismGraphN, i : Int, v : Double) -> ChemrxnmechanismGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_graphn_sum(s : ChemrxnmechanismGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_graphn_mean(s : ChemrxnmechanismGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_graphn_scale(s : ChemrxnmechanismGraphN, f : Double) -> ChemrxnmechanismGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_graphn_add(a : ChemrxnmechanismGraphN, b : ChemrxnmechanismGraphN) -> ChemrxnmechanismGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_graphn_copy(s : ChemrxnmechanismGraphN) -> ChemrxnmechanismGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_graphn_fill(s : ChemrxnmechanismGraphN, v : Double) -> ChemrxnmechanismGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_graphn_min(s : ChemrxnmechanismGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_graphn_max(s : ChemrxnmechanismGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_graphn_to_string(s : ChemrxnmechanismGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_node_make(size : Int) -> ChemrxnmechanismNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_node_len(s : ChemrxnmechanismNode) -> Int { s.size }

pub fn chem_rxn_mechanism_node_get(s : ChemrxnmechanismNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_node_set(s : ChemrxnmechanismNode, i : Int, v : Double) -> ChemrxnmechanismNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_node_sum(s : ChemrxnmechanismNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_node_mean(s : ChemrxnmechanismNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_node_scale(s : ChemrxnmechanismNode, f : Double) -> ChemrxnmechanismNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_node_add(a : ChemrxnmechanismNode, b : ChemrxnmechanismNode) -> ChemrxnmechanismNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_node_copy(s : ChemrxnmechanismNode) -> ChemrxnmechanismNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_node_fill(s : ChemrxnmechanismNode, v : Double) -> ChemrxnmechanismNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_node_min(s : ChemrxnmechanismNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_node_max(s : ChemrxnmechanismNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_node_to_string(s : ChemrxnmechanismNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_edge_make(size : Int) -> ChemrxnmechanismEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_edge_len(s : ChemrxnmechanismEdge) -> Int { s.size }

pub fn chem_rxn_mechanism_edge_get(s : ChemrxnmechanismEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_edge_set(s : ChemrxnmechanismEdge, i : Int, v : Double) -> ChemrxnmechanismEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_edge_sum(s : ChemrxnmechanismEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_edge_mean(s : ChemrxnmechanismEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_edge_scale(s : ChemrxnmechanismEdge, f : Double) -> ChemrxnmechanismEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_edge_add(a : ChemrxnmechanismEdge, b : ChemrxnmechanismEdge) -> ChemrxnmechanismEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_edge_copy(s : ChemrxnmechanismEdge) -> ChemrxnmechanismEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_edge_fill(s : ChemrxnmechanismEdge, v : Double) -> ChemrxnmechanismEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_edge_min(s : ChemrxnmechanismEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_edge_max(s : ChemrxnmechanismEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_edge_to_string(s : ChemrxnmechanismEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_path_make(size : Int) -> ChemrxnmechanismPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_path_len(s : ChemrxnmechanismPath) -> Int { s.size }

pub fn chem_rxn_mechanism_path_get(s : ChemrxnmechanismPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_path_set(s : ChemrxnmechanismPath, i : Int, v : Double) -> ChemrxnmechanismPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_path_sum(s : ChemrxnmechanismPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_path_mean(s : ChemrxnmechanismPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_path_scale(s : ChemrxnmechanismPath, f : Double) -> ChemrxnmechanismPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_path_add(a : ChemrxnmechanismPath, b : ChemrxnmechanismPath) -> ChemrxnmechanismPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_path_copy(s : ChemrxnmechanismPath) -> ChemrxnmechanismPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_path_fill(s : ChemrxnmechanismPath, v : Double) -> ChemrxnmechanismPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_path_min(s : ChemrxnmechanismPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_path_max(s : ChemrxnmechanismPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_path_to_string(s : ChemrxnmechanismPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_cluster_make(size : Int) -> ChemrxnmechanismCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_cluster_len(s : ChemrxnmechanismCluster) -> Int { s.size }

pub fn chem_rxn_mechanism_cluster_get(s : ChemrxnmechanismCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_cluster_set(s : ChemrxnmechanismCluster, i : Int, v : Double) -> ChemrxnmechanismCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cluster_sum(s : ChemrxnmechanismCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_cluster_mean(s : ChemrxnmechanismCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_cluster_scale(s : ChemrxnmechanismCluster, f : Double) -> ChemrxnmechanismCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cluster_add(a : ChemrxnmechanismCluster, b : ChemrxnmechanismCluster) -> ChemrxnmechanismCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_cluster_copy(s : ChemrxnmechanismCluster) -> ChemrxnmechanismCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cluster_fill(s : ChemrxnmechanismCluster, v : Double) -> ChemrxnmechanismCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cluster_min(s : ChemrxnmechanismCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_cluster_max(s : ChemrxnmechanismCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_cluster_to_string(s : ChemrxnmechanismCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_model_make(size : Int) -> ChemrxnmechanismModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_model_len(s : ChemrxnmechanismModel) -> Int { s.size }

pub fn chem_rxn_mechanism_model_get(s : ChemrxnmechanismModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_model_set(s : ChemrxnmechanismModel, i : Int, v : Double) -> ChemrxnmechanismModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_model_sum(s : ChemrxnmechanismModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_model_mean(s : ChemrxnmechanismModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_model_scale(s : ChemrxnmechanismModel, f : Double) -> ChemrxnmechanismModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_model_add(a : ChemrxnmechanismModel, b : ChemrxnmechanismModel) -> ChemrxnmechanismModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_model_copy(s : ChemrxnmechanismModel) -> ChemrxnmechanismModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_model_fill(s : ChemrxnmechanismModel, v : Double) -> ChemrxnmechanismModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_model_min(s : ChemrxnmechanismModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_model_max(s : ChemrxnmechanismModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_model_to_string(s : ChemrxnmechanismModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_layer_make(size : Int) -> ChemrxnmechanismLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_layer_len(s : ChemrxnmechanismLayer) -> Int { s.size }

pub fn chem_rxn_mechanism_layer_get(s : ChemrxnmechanismLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_layer_set(s : ChemrxnmechanismLayer, i : Int, v : Double) -> ChemrxnmechanismLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_layer_sum(s : ChemrxnmechanismLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_layer_mean(s : ChemrxnmechanismLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_layer_scale(s : ChemrxnmechanismLayer, f : Double) -> ChemrxnmechanismLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_layer_add(a : ChemrxnmechanismLayer, b : ChemrxnmechanismLayer) -> ChemrxnmechanismLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_layer_copy(s : ChemrxnmechanismLayer) -> ChemrxnmechanismLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_layer_fill(s : ChemrxnmechanismLayer, v : Double) -> ChemrxnmechanismLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_layer_min(s : ChemrxnmechanismLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_layer_max(s : ChemrxnmechanismLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_layer_to_string(s : ChemrxnmechanismLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_buffer_make(size : Int) -> ChemrxnmechanismBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_buffer_len(s : ChemrxnmechanismBuffer) -> Int { s.size }

pub fn chem_rxn_mechanism_buffer_get(s : ChemrxnmechanismBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_buffer_set(s : ChemrxnmechanismBuffer, i : Int, v : Double) -> ChemrxnmechanismBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_buffer_sum(s : ChemrxnmechanismBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_buffer_mean(s : ChemrxnmechanismBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_buffer_scale(s : ChemrxnmechanismBuffer, f : Double) -> ChemrxnmechanismBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_buffer_add(a : ChemrxnmechanismBuffer, b : ChemrxnmechanismBuffer) -> ChemrxnmechanismBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_buffer_copy(s : ChemrxnmechanismBuffer) -> ChemrxnmechanismBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_buffer_fill(s : ChemrxnmechanismBuffer, v : Double) -> ChemrxnmechanismBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_buffer_min(s : ChemrxnmechanismBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_buffer_max(s : ChemrxnmechanismBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_buffer_to_string(s : ChemrxnmechanismBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_cursor_make(size : Int) -> ChemrxnmechanismCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_cursor_len(s : ChemrxnmechanismCursor) -> Int { s.size }

pub fn chem_rxn_mechanism_cursor_get(s : ChemrxnmechanismCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_cursor_set(s : ChemrxnmechanismCursor, i : Int, v : Double) -> ChemrxnmechanismCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cursor_sum(s : ChemrxnmechanismCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_cursor_mean(s : ChemrxnmechanismCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_cursor_scale(s : ChemrxnmechanismCursor, f : Double) -> ChemrxnmechanismCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cursor_add(a : ChemrxnmechanismCursor, b : ChemrxnmechanismCursor) -> ChemrxnmechanismCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_cursor_copy(s : ChemrxnmechanismCursor) -> ChemrxnmechanismCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cursor_fill(s : ChemrxnmechanismCursor, v : Double) -> ChemrxnmechanismCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_cursor_min(s : ChemrxnmechanismCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_cursor_max(s : ChemrxnmechanismCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_cursor_to_string(s : ChemrxnmechanismCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_view_make(size : Int) -> ChemrxnmechanismView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_view_len(s : ChemrxnmechanismView) -> Int { s.size }

pub fn chem_rxn_mechanism_view_get(s : ChemrxnmechanismView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_view_set(s : ChemrxnmechanismView, i : Int, v : Double) -> ChemrxnmechanismView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_view_sum(s : ChemrxnmechanismView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_view_mean(s : ChemrxnmechanismView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_view_scale(s : ChemrxnmechanismView, f : Double) -> ChemrxnmechanismView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_view_add(a : ChemrxnmechanismView, b : ChemrxnmechanismView) -> ChemrxnmechanismView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_view_copy(s : ChemrxnmechanismView) -> ChemrxnmechanismView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_view_fill(s : ChemrxnmechanismView, v : Double) -> ChemrxnmechanismView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_view_min(s : ChemrxnmechanismView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_view_max(s : ChemrxnmechanismView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_view_to_string(s : ChemrxnmechanismView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_range_make(size : Int) -> ChemrxnmechanismRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_range_len(s : ChemrxnmechanismRange) -> Int { s.size }

pub fn chem_rxn_mechanism_range_get(s : ChemrxnmechanismRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_range_set(s : ChemrxnmechanismRange, i : Int, v : Double) -> ChemrxnmechanismRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_range_sum(s : ChemrxnmechanismRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_range_mean(s : ChemrxnmechanismRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_range_scale(s : ChemrxnmechanismRange, f : Double) -> ChemrxnmechanismRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_range_add(a : ChemrxnmechanismRange, b : ChemrxnmechanismRange) -> ChemrxnmechanismRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_range_copy(s : ChemrxnmechanismRange) -> ChemrxnmechanismRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_range_fill(s : ChemrxnmechanismRange, v : Double) -> ChemrxnmechanismRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_range_min(s : ChemrxnmechanismRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_range_max(s : ChemrxnmechanismRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_range_to_string(s : ChemrxnmechanismRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_slice_make(size : Int) -> ChemrxnmechanismSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_slice_len(s : ChemrxnmechanismSlice) -> Int { s.size }

pub fn chem_rxn_mechanism_slice_get(s : ChemrxnmechanismSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_slice_set(s : ChemrxnmechanismSlice, i : Int, v : Double) -> ChemrxnmechanismSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_slice_sum(s : ChemrxnmechanismSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_mechanism_slice_mean(s : ChemrxnmechanismSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_mechanism_slice_scale(s : ChemrxnmechanismSlice, f : Double) -> ChemrxnmechanismSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_slice_add(a : ChemrxnmechanismSlice, b : ChemrxnmechanismSlice) -> ChemrxnmechanismSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_mechanism_slice_copy(s : ChemrxnmechanismSlice) -> ChemrxnmechanismSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_slice_fill(s : ChemrxnmechanismSlice, v : Double) -> ChemrxnmechanismSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_mechanism_slice_min(s : ChemrxnmechanismSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_mechanism_slice_max(s : ChemrxnmechanismSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_mechanism_slice_to_string(s : ChemrxnmechanismSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

