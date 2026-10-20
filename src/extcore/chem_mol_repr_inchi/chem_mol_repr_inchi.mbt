///===
/// extcore/chem_mol_repr_inchi

pub(all) struct ChemmolreprinchiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_inchi_make_point(x : Double, y : Double) -> ChemmolreprinchiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_inchi_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprinchiPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprinchiPoint::x(self : ChemmolreprinchiPoint) -> Double { self.x }

pub fn ChemmolreprinchiPoint::y(self : ChemmolreprinchiPoint) -> Double { self.y }

pub fn ChemmolreprinchiPoint::z(self : ChemmolreprinchiPoint) -> Double { self.z }

pub fn ChemmolreprinchiPoint::label(self : ChemmolreprinchiPoint) -> Int { self.label }

pub fn ChemmolreprinchiPoint::dist(self : ChemmolreprinchiPoint, other : ChemmolreprinchiPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprinchiPoint::add(self : ChemmolreprinchiPoint, other : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprinchiPoint::sub(self : ChemmolreprinchiPoint, other : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprinchiPoint::scale(self : ChemmolreprinchiPoint, s : Double) -> ChemmolreprinchiPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprinchiPoint::dot(self : ChemmolreprinchiPoint, other : ChemmolreprinchiPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprinchiPoint::cross(self : ChemmolreprinchiPoint, other : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprinchiPoint::norm(self : ChemmolreprinchiPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprinchiPoint::normalize(self : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprinchiPoint::negate(self : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprinchiPoint::mid(self : ChemmolreprinchiPoint, other : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprinchiPoint::lerp(self : ChemmolreprinchiPoint, other : ChemmolreprinchiPoint, t : Double) -> ChemmolreprinchiPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprinchiPoint::to_string(self : ChemmolreprinchiPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprinchiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_inchi_make_series(vals : Array[Double], name : String) -> ChemmolreprinchiSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprinchiSeries::len(self : ChemmolreprinchiSeries) -> Int { self.vals.length() }

pub fn ChemmolreprinchiSeries::sum(self : ChemmolreprinchiSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprinchiSeries::mean(self : ChemmolreprinchiSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprinchiSeries::min(self : ChemmolreprinchiSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprinchiSeries::max(self : ChemmolreprinchiSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprinchiSeries::range(self : ChemmolreprinchiSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprinchiSeries::variance(self : ChemmolreprinchiSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprinchiSeries::std(self : ChemmolreprinchiSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprinchiSeries::median(self : ChemmolreprinchiSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprinchiSeries::scale(self : ChemmolreprinchiSeries, f : Double) -> ChemmolreprinchiSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprinchiSeries::add(self : ChemmolreprinchiSeries, other : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprinchiSeries::sub(self : ChemmolreprinchiSeries, other : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprinchiSeries::normalize(self : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprinchiSeries::cumsum(self : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprinchiSeries::to_string(self : ChemmolreprinchiSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprinchiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_inchi_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprinchiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_inchi_matrix_identity(n : Int) -> ChemmolreprinchiMatrix {
  let m = chem_mol_repr_inchi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprinchiMatrix::get(self : ChemmolreprinchiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprinchiMatrix::transpose(self : ChemmolreprinchiMatrix) -> ChemmolreprinchiMatrix {
  let result = chem_mol_repr_inchi_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprinchiMatrix::add(self : ChemmolreprinchiMatrix, other : ChemmolreprinchiMatrix) -> ChemmolreprinchiMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_inchi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprinchiMatrix::scale(self : ChemmolreprinchiMatrix, s : Double) -> ChemmolreprinchiMatrix {
  let result = chem_mol_repr_inchi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprinchiMatrix::multiply(self : ChemmolreprinchiMatrix, other : ChemmolreprinchiMatrix) -> ChemmolreprinchiMatrix {
  if self.cols != other.rows { return chem_mol_repr_inchi_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_inchi_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprinchiMatrix::trace(self : ChemmolreprinchiMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprinchiMatrix::det(self : ChemmolreprinchiMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprinchiMatrix::norm(self : ChemmolreprinchiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprinchiMatrix::to_string(self : ChemmolreprinchiMatrix) -> String {
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

pub(all) struct ChemmolreprinchiVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_inchi_make_vector(comps : Array[Double]) -> ChemmolreprinchiVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_inchi_vector_zero(dim : Int) -> ChemmolreprinchiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprinchiVector::add(self : ChemmolreprinchiVector, other : ChemmolreprinchiVector) -> ChemmolreprinchiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprinchiVector::sub(self : ChemmolreprinchiVector, other : ChemmolreprinchiVector) -> ChemmolreprinchiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprinchiVector::scale(self : ChemmolreprinchiVector, s : Double) -> ChemmolreprinchiVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprinchiVector::dot(self : ChemmolreprinchiVector, other : ChemmolreprinchiVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprinchiVector::norm(self : ChemmolreprinchiVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprinchiVector::normalize(self : ChemmolreprinchiVector) -> ChemmolreprinchiVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprinchiVector::dist(self : ChemmolreprinchiVector, other : ChemmolreprinchiVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprinchiVector::to_string(self : ChemmolreprinchiVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_inchi_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_inchi_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_inchi_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_inchi_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_inchi_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_inchi_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_inchi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_inchi_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_inchi_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_inchi_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_inchi_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_inchi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_inchi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_inchi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_inchi_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_inchi_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_inchi_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_inchi_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_inchi_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_inchi_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_inchi_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_inchi_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_inchi_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_inchi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_inchi_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_inchi_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_inchi_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_inchi_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_inchi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprinchiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_frame_make(size : Int) -> ChemmolreprinchiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_frame_len(s : ChemmolreprinchiFrame) -> Int { s.size }

pub fn chem_mol_repr_inchi_frame_get(s : ChemmolreprinchiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_frame_set(s : ChemmolreprinchiFrame, i : Int, v : Double) -> ChemmolreprinchiFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_frame_sum(s : ChemmolreprinchiFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_frame_mean(s : ChemmolreprinchiFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_frame_scale(s : ChemmolreprinchiFrame, f : Double) -> ChemmolreprinchiFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_frame_add(a : ChemmolreprinchiFrame, b : ChemmolreprinchiFrame) -> ChemmolreprinchiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_frame_copy(s : ChemmolreprinchiFrame) -> ChemmolreprinchiFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_frame_fill(s : ChemmolreprinchiFrame, v : Double) -> ChemmolreprinchiFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_frame_min(s : ChemmolreprinchiFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_frame_max(s : ChemmolreprinchiFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_frame_to_string(s : ChemmolreprinchiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_table_make(size : Int) -> ChemmolreprinchiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_table_len(s : ChemmolreprinchiTable) -> Int { s.size }

pub fn chem_mol_repr_inchi_table_get(s : ChemmolreprinchiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_table_set(s : ChemmolreprinchiTable, i : Int, v : Double) -> ChemmolreprinchiTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_table_sum(s : ChemmolreprinchiTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_table_mean(s : ChemmolreprinchiTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_table_scale(s : ChemmolreprinchiTable, f : Double) -> ChemmolreprinchiTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_table_add(a : ChemmolreprinchiTable, b : ChemmolreprinchiTable) -> ChemmolreprinchiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_table_copy(s : ChemmolreprinchiTable) -> ChemmolreprinchiTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_table_fill(s : ChemmolreprinchiTable, v : Double) -> ChemmolreprinchiTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_table_min(s : ChemmolreprinchiTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_table_max(s : ChemmolreprinchiTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_table_to_string(s : ChemmolreprinchiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_graphn_make(size : Int) -> ChemmolreprinchiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_graphn_len(s : ChemmolreprinchiGraphN) -> Int { s.size }

pub fn chem_mol_repr_inchi_graphn_get(s : ChemmolreprinchiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_graphn_set(s : ChemmolreprinchiGraphN, i : Int, v : Double) -> ChemmolreprinchiGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_graphn_sum(s : ChemmolreprinchiGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_graphn_mean(s : ChemmolreprinchiGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_graphn_scale(s : ChemmolreprinchiGraphN, f : Double) -> ChemmolreprinchiGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_graphn_add(a : ChemmolreprinchiGraphN, b : ChemmolreprinchiGraphN) -> ChemmolreprinchiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_graphn_copy(s : ChemmolreprinchiGraphN) -> ChemmolreprinchiGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_graphn_fill(s : ChemmolreprinchiGraphN, v : Double) -> ChemmolreprinchiGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_graphn_min(s : ChemmolreprinchiGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_graphn_max(s : ChemmolreprinchiGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_graphn_to_string(s : ChemmolreprinchiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_node_make(size : Int) -> ChemmolreprinchiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_node_len(s : ChemmolreprinchiNode) -> Int { s.size }

pub fn chem_mol_repr_inchi_node_get(s : ChemmolreprinchiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_node_set(s : ChemmolreprinchiNode, i : Int, v : Double) -> ChemmolreprinchiNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_node_sum(s : ChemmolreprinchiNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_node_mean(s : ChemmolreprinchiNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_node_scale(s : ChemmolreprinchiNode, f : Double) -> ChemmolreprinchiNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_node_add(a : ChemmolreprinchiNode, b : ChemmolreprinchiNode) -> ChemmolreprinchiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_node_copy(s : ChemmolreprinchiNode) -> ChemmolreprinchiNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_node_fill(s : ChemmolreprinchiNode, v : Double) -> ChemmolreprinchiNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_node_min(s : ChemmolreprinchiNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_node_max(s : ChemmolreprinchiNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_node_to_string(s : ChemmolreprinchiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_edge_make(size : Int) -> ChemmolreprinchiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_edge_len(s : ChemmolreprinchiEdge) -> Int { s.size }

pub fn chem_mol_repr_inchi_edge_get(s : ChemmolreprinchiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_edge_set(s : ChemmolreprinchiEdge, i : Int, v : Double) -> ChemmolreprinchiEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_edge_sum(s : ChemmolreprinchiEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_edge_mean(s : ChemmolreprinchiEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_edge_scale(s : ChemmolreprinchiEdge, f : Double) -> ChemmolreprinchiEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_edge_add(a : ChemmolreprinchiEdge, b : ChemmolreprinchiEdge) -> ChemmolreprinchiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_edge_copy(s : ChemmolreprinchiEdge) -> ChemmolreprinchiEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_edge_fill(s : ChemmolreprinchiEdge, v : Double) -> ChemmolreprinchiEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_edge_min(s : ChemmolreprinchiEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_edge_max(s : ChemmolreprinchiEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_edge_to_string(s : ChemmolreprinchiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_path_make(size : Int) -> ChemmolreprinchiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_path_len(s : ChemmolreprinchiPath) -> Int { s.size }

pub fn chem_mol_repr_inchi_path_get(s : ChemmolreprinchiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_path_set(s : ChemmolreprinchiPath, i : Int, v : Double) -> ChemmolreprinchiPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_path_sum(s : ChemmolreprinchiPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_path_mean(s : ChemmolreprinchiPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_path_scale(s : ChemmolreprinchiPath, f : Double) -> ChemmolreprinchiPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_path_add(a : ChemmolreprinchiPath, b : ChemmolreprinchiPath) -> ChemmolreprinchiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_path_copy(s : ChemmolreprinchiPath) -> ChemmolreprinchiPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_path_fill(s : ChemmolreprinchiPath, v : Double) -> ChemmolreprinchiPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_path_min(s : ChemmolreprinchiPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_path_max(s : ChemmolreprinchiPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_path_to_string(s : ChemmolreprinchiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_cluster_make(size : Int) -> ChemmolreprinchiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_cluster_len(s : ChemmolreprinchiCluster) -> Int { s.size }

pub fn chem_mol_repr_inchi_cluster_get(s : ChemmolreprinchiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_cluster_set(s : ChemmolreprinchiCluster, i : Int, v : Double) -> ChemmolreprinchiCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cluster_sum(s : ChemmolreprinchiCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_cluster_mean(s : ChemmolreprinchiCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_cluster_scale(s : ChemmolreprinchiCluster, f : Double) -> ChemmolreprinchiCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cluster_add(a : ChemmolreprinchiCluster, b : ChemmolreprinchiCluster) -> ChemmolreprinchiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_cluster_copy(s : ChemmolreprinchiCluster) -> ChemmolreprinchiCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cluster_fill(s : ChemmolreprinchiCluster, v : Double) -> ChemmolreprinchiCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cluster_min(s : ChemmolreprinchiCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_cluster_max(s : ChemmolreprinchiCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_cluster_to_string(s : ChemmolreprinchiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_model_make(size : Int) -> ChemmolreprinchiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_model_len(s : ChemmolreprinchiModel) -> Int { s.size }

pub fn chem_mol_repr_inchi_model_get(s : ChemmolreprinchiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_model_set(s : ChemmolreprinchiModel, i : Int, v : Double) -> ChemmolreprinchiModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_model_sum(s : ChemmolreprinchiModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_model_mean(s : ChemmolreprinchiModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_model_scale(s : ChemmolreprinchiModel, f : Double) -> ChemmolreprinchiModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_model_add(a : ChemmolreprinchiModel, b : ChemmolreprinchiModel) -> ChemmolreprinchiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_model_copy(s : ChemmolreprinchiModel) -> ChemmolreprinchiModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_model_fill(s : ChemmolreprinchiModel, v : Double) -> ChemmolreprinchiModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_model_min(s : ChemmolreprinchiModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_model_max(s : ChemmolreprinchiModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_model_to_string(s : ChemmolreprinchiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_layer_make(size : Int) -> ChemmolreprinchiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_layer_len(s : ChemmolreprinchiLayer) -> Int { s.size }

pub fn chem_mol_repr_inchi_layer_get(s : ChemmolreprinchiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_layer_set(s : ChemmolreprinchiLayer, i : Int, v : Double) -> ChemmolreprinchiLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_layer_sum(s : ChemmolreprinchiLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_layer_mean(s : ChemmolreprinchiLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_layer_scale(s : ChemmolreprinchiLayer, f : Double) -> ChemmolreprinchiLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_layer_add(a : ChemmolreprinchiLayer, b : ChemmolreprinchiLayer) -> ChemmolreprinchiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_layer_copy(s : ChemmolreprinchiLayer) -> ChemmolreprinchiLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_layer_fill(s : ChemmolreprinchiLayer, v : Double) -> ChemmolreprinchiLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_layer_min(s : ChemmolreprinchiLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_layer_max(s : ChemmolreprinchiLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_layer_to_string(s : ChemmolreprinchiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_buffer_make(size : Int) -> ChemmolreprinchiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_buffer_len(s : ChemmolreprinchiBuffer) -> Int { s.size }

pub fn chem_mol_repr_inchi_buffer_get(s : ChemmolreprinchiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_buffer_set(s : ChemmolreprinchiBuffer, i : Int, v : Double) -> ChemmolreprinchiBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_buffer_sum(s : ChemmolreprinchiBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_buffer_mean(s : ChemmolreprinchiBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_buffer_scale(s : ChemmolreprinchiBuffer, f : Double) -> ChemmolreprinchiBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_buffer_add(a : ChemmolreprinchiBuffer, b : ChemmolreprinchiBuffer) -> ChemmolreprinchiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_buffer_copy(s : ChemmolreprinchiBuffer) -> ChemmolreprinchiBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_buffer_fill(s : ChemmolreprinchiBuffer, v : Double) -> ChemmolreprinchiBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_buffer_min(s : ChemmolreprinchiBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_buffer_max(s : ChemmolreprinchiBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_buffer_to_string(s : ChemmolreprinchiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_cursor_make(size : Int) -> ChemmolreprinchiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_cursor_len(s : ChemmolreprinchiCursor) -> Int { s.size }

pub fn chem_mol_repr_inchi_cursor_get(s : ChemmolreprinchiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_cursor_set(s : ChemmolreprinchiCursor, i : Int, v : Double) -> ChemmolreprinchiCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cursor_sum(s : ChemmolreprinchiCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_cursor_mean(s : ChemmolreprinchiCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_cursor_scale(s : ChemmolreprinchiCursor, f : Double) -> ChemmolreprinchiCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cursor_add(a : ChemmolreprinchiCursor, b : ChemmolreprinchiCursor) -> ChemmolreprinchiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_cursor_copy(s : ChemmolreprinchiCursor) -> ChemmolreprinchiCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cursor_fill(s : ChemmolreprinchiCursor, v : Double) -> ChemmolreprinchiCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_cursor_min(s : ChemmolreprinchiCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_cursor_max(s : ChemmolreprinchiCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_cursor_to_string(s : ChemmolreprinchiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_view_make(size : Int) -> ChemmolreprinchiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_view_len(s : ChemmolreprinchiView) -> Int { s.size }

pub fn chem_mol_repr_inchi_view_get(s : ChemmolreprinchiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_view_set(s : ChemmolreprinchiView, i : Int, v : Double) -> ChemmolreprinchiView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_view_sum(s : ChemmolreprinchiView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_view_mean(s : ChemmolreprinchiView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_view_scale(s : ChemmolreprinchiView, f : Double) -> ChemmolreprinchiView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_view_add(a : ChemmolreprinchiView, b : ChemmolreprinchiView) -> ChemmolreprinchiView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_view_copy(s : ChemmolreprinchiView) -> ChemmolreprinchiView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_view_fill(s : ChemmolreprinchiView, v : Double) -> ChemmolreprinchiView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_view_min(s : ChemmolreprinchiView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_view_max(s : ChemmolreprinchiView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_view_to_string(s : ChemmolreprinchiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_range_make(size : Int) -> ChemmolreprinchiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_range_len(s : ChemmolreprinchiRange) -> Int { s.size }

pub fn chem_mol_repr_inchi_range_get(s : ChemmolreprinchiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_range_set(s : ChemmolreprinchiRange, i : Int, v : Double) -> ChemmolreprinchiRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_range_sum(s : ChemmolreprinchiRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_range_mean(s : ChemmolreprinchiRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_range_scale(s : ChemmolreprinchiRange, f : Double) -> ChemmolreprinchiRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_range_add(a : ChemmolreprinchiRange, b : ChemmolreprinchiRange) -> ChemmolreprinchiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_range_copy(s : ChemmolreprinchiRange) -> ChemmolreprinchiRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_range_fill(s : ChemmolreprinchiRange, v : Double) -> ChemmolreprinchiRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_range_min(s : ChemmolreprinchiRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_range_max(s : ChemmolreprinchiRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_range_to_string(s : ChemmolreprinchiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_slice_make(size : Int) -> ChemmolreprinchiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_slice_len(s : ChemmolreprinchiSlice) -> Int { s.size }

pub fn chem_mol_repr_inchi_slice_get(s : ChemmolreprinchiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_slice_set(s : ChemmolreprinchiSlice, i : Int, v : Double) -> ChemmolreprinchiSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_slice_sum(s : ChemmolreprinchiSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_inchi_slice_mean(s : ChemmolreprinchiSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_inchi_slice_scale(s : ChemmolreprinchiSlice, f : Double) -> ChemmolreprinchiSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_slice_add(a : ChemmolreprinchiSlice, b : ChemmolreprinchiSlice) -> ChemmolreprinchiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_inchi_slice_copy(s : ChemmolreprinchiSlice) -> ChemmolreprinchiSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_slice_fill(s : ChemmolreprinchiSlice, v : Double) -> ChemmolreprinchiSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_inchi_slice_min(s : ChemmolreprinchiSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_inchi_slice_max(s : ChemmolreprinchiSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_inchi_slice_to_string(s : ChemmolreprinchiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

