///===
/// extcore/chem_mol_repr_aromatic

pub(all) struct ChemmolrepraromaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_aromatic_make_point(x : Double, y : Double) -> ChemmolrepraromaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_aromatic_make_point3(x : Double, y : Double, z : Double) -> ChemmolrepraromaticPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolrepraromaticPoint::x(self : ChemmolrepraromaticPoint) -> Double { self.x }

pub fn ChemmolrepraromaticPoint::y(self : ChemmolrepraromaticPoint) -> Double { self.y }

pub fn ChemmolrepraromaticPoint::z(self : ChemmolrepraromaticPoint) -> Double { self.z }

pub fn ChemmolrepraromaticPoint::label(self : ChemmolrepraromaticPoint) -> Int { self.label }

pub fn ChemmolrepraromaticPoint::dist(self : ChemmolrepraromaticPoint, other : ChemmolrepraromaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolrepraromaticPoint::add(self : ChemmolrepraromaticPoint, other : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolrepraromaticPoint::sub(self : ChemmolrepraromaticPoint, other : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolrepraromaticPoint::scale(self : ChemmolrepraromaticPoint, s : Double) -> ChemmolrepraromaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolrepraromaticPoint::dot(self : ChemmolrepraromaticPoint, other : ChemmolrepraromaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolrepraromaticPoint::cross(self : ChemmolrepraromaticPoint, other : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolrepraromaticPoint::norm(self : ChemmolrepraromaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolrepraromaticPoint::normalize(self : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolrepraromaticPoint::negate(self : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolrepraromaticPoint::mid(self : ChemmolrepraromaticPoint, other : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolrepraromaticPoint::lerp(self : ChemmolrepraromaticPoint, other : ChemmolrepraromaticPoint, t : Double) -> ChemmolrepraromaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolrepraromaticPoint::to_string(self : ChemmolrepraromaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_aromatic_make_series(vals : Array[Double], name : String) -> ChemmolrepraromaticSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolrepraromaticSeries::len(self : ChemmolrepraromaticSeries) -> Int { self.vals.length() }

pub fn ChemmolrepraromaticSeries::sum(self : ChemmolrepraromaticSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolrepraromaticSeries::mean(self : ChemmolrepraromaticSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolrepraromaticSeries::min(self : ChemmolrepraromaticSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolrepraromaticSeries::max(self : ChemmolrepraromaticSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolrepraromaticSeries::range(self : ChemmolrepraromaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolrepraromaticSeries::variance(self : ChemmolrepraromaticSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolrepraromaticSeries::std(self : ChemmolrepraromaticSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolrepraromaticSeries::median(self : ChemmolrepraromaticSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolrepraromaticSeries::scale(self : ChemmolrepraromaticSeries, f : Double) -> ChemmolrepraromaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolrepraromaticSeries::add(self : ChemmolrepraromaticSeries, other : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolrepraromaticSeries::sub(self : ChemmolrepraromaticSeries, other : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolrepraromaticSeries::normalize(self : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolrepraromaticSeries::cumsum(self : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolrepraromaticSeries::to_string(self : ChemmolrepraromaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolrepraromaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_aromatic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolrepraromaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_aromatic_matrix_identity(n : Int) -> ChemmolrepraromaticMatrix {
  let m = chem_mol_repr_aromatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolrepraromaticMatrix::get(self : ChemmolrepraromaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolrepraromaticMatrix::transpose(self : ChemmolrepraromaticMatrix) -> ChemmolrepraromaticMatrix {
  let result = chem_mol_repr_aromatic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolrepraromaticMatrix::add(self : ChemmolrepraromaticMatrix, other : ChemmolrepraromaticMatrix) -> ChemmolrepraromaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolrepraromaticMatrix::scale(self : ChemmolrepraromaticMatrix, s : Double) -> ChemmolrepraromaticMatrix {
  let result = chem_mol_repr_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolrepraromaticMatrix::multiply(self : ChemmolrepraromaticMatrix, other : ChemmolrepraromaticMatrix) -> ChemmolrepraromaticMatrix {
  if self.cols != other.rows { return chem_mol_repr_aromatic_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_aromatic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolrepraromaticMatrix::trace(self : ChemmolrepraromaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolrepraromaticMatrix::det(self : ChemmolrepraromaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolrepraromaticMatrix::norm(self : ChemmolrepraromaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolrepraromaticMatrix::to_string(self : ChemmolrepraromaticMatrix) -> String {
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

pub(all) struct ChemmolrepraromaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_aromatic_make_vector(comps : Array[Double]) -> ChemmolrepraromaticVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_aromatic_vector_zero(dim : Int) -> ChemmolrepraromaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolrepraromaticVector::add(self : ChemmolrepraromaticVector, other : ChemmolrepraromaticVector) -> ChemmolrepraromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolrepraromaticVector::sub(self : ChemmolrepraromaticVector, other : ChemmolrepraromaticVector) -> ChemmolrepraromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolrepraromaticVector::scale(self : ChemmolrepraromaticVector, s : Double) -> ChemmolrepraromaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolrepraromaticVector::dot(self : ChemmolrepraromaticVector, other : ChemmolrepraromaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolrepraromaticVector::norm(self : ChemmolrepraromaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolrepraromaticVector::normalize(self : ChemmolrepraromaticVector) -> ChemmolrepraromaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolrepraromaticVector::dist(self : ChemmolrepraromaticVector, other : ChemmolrepraromaticVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolrepraromaticVector::to_string(self : ChemmolrepraromaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_aromatic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_aromatic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_aromatic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_aromatic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_aromatic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_aromatic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_aromatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_aromatic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_aromatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_aromatic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_aromatic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_aromatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_aromatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_aromatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_aromatic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_aromatic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_aromatic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_aromatic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_aromatic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_aromatic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_aromatic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_aromatic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_aromatic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_aromatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_aromatic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_aromatic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_aromatic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_aromatic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_aromatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolrepraromaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_frame_make(size : Int) -> ChemmolrepraromaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_frame_len(s : ChemmolrepraromaticFrame) -> Int { s.size }

pub fn chem_mol_repr_aromatic_frame_get(s : ChemmolrepraromaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_frame_set(s : ChemmolrepraromaticFrame, i : Int, v : Double) -> ChemmolrepraromaticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_frame_sum(s : ChemmolrepraromaticFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_frame_mean(s : ChemmolrepraromaticFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_frame_scale(s : ChemmolrepraromaticFrame, f : Double) -> ChemmolrepraromaticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_frame_add(a : ChemmolrepraromaticFrame, b : ChemmolrepraromaticFrame) -> ChemmolrepraromaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_frame_copy(s : ChemmolrepraromaticFrame) -> ChemmolrepraromaticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_frame_fill(s : ChemmolrepraromaticFrame, v : Double) -> ChemmolrepraromaticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_frame_min(s : ChemmolrepraromaticFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_frame_max(s : ChemmolrepraromaticFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_frame_to_string(s : ChemmolrepraromaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_table_make(size : Int) -> ChemmolrepraromaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_table_len(s : ChemmolrepraromaticTable) -> Int { s.size }

pub fn chem_mol_repr_aromatic_table_get(s : ChemmolrepraromaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_table_set(s : ChemmolrepraromaticTable, i : Int, v : Double) -> ChemmolrepraromaticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_table_sum(s : ChemmolrepraromaticTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_table_mean(s : ChemmolrepraromaticTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_table_scale(s : ChemmolrepraromaticTable, f : Double) -> ChemmolrepraromaticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_table_add(a : ChemmolrepraromaticTable, b : ChemmolrepraromaticTable) -> ChemmolrepraromaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_table_copy(s : ChemmolrepraromaticTable) -> ChemmolrepraromaticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_table_fill(s : ChemmolrepraromaticTable, v : Double) -> ChemmolrepraromaticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_table_min(s : ChemmolrepraromaticTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_table_max(s : ChemmolrepraromaticTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_table_to_string(s : ChemmolrepraromaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_graphn_make(size : Int) -> ChemmolrepraromaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_graphn_len(s : ChemmolrepraromaticGraphN) -> Int { s.size }

pub fn chem_mol_repr_aromatic_graphn_get(s : ChemmolrepraromaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_graphn_set(s : ChemmolrepraromaticGraphN, i : Int, v : Double) -> ChemmolrepraromaticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_graphn_sum(s : ChemmolrepraromaticGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_graphn_mean(s : ChemmolrepraromaticGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_graphn_scale(s : ChemmolrepraromaticGraphN, f : Double) -> ChemmolrepraromaticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_graphn_add(a : ChemmolrepraromaticGraphN, b : ChemmolrepraromaticGraphN) -> ChemmolrepraromaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_graphn_copy(s : ChemmolrepraromaticGraphN) -> ChemmolrepraromaticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_graphn_fill(s : ChemmolrepraromaticGraphN, v : Double) -> ChemmolrepraromaticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_graphn_min(s : ChemmolrepraromaticGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_graphn_max(s : ChemmolrepraromaticGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_graphn_to_string(s : ChemmolrepraromaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_node_make(size : Int) -> ChemmolrepraromaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_node_len(s : ChemmolrepraromaticNode) -> Int { s.size }

pub fn chem_mol_repr_aromatic_node_get(s : ChemmolrepraromaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_node_set(s : ChemmolrepraromaticNode, i : Int, v : Double) -> ChemmolrepraromaticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_node_sum(s : ChemmolrepraromaticNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_node_mean(s : ChemmolrepraromaticNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_node_scale(s : ChemmolrepraromaticNode, f : Double) -> ChemmolrepraromaticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_node_add(a : ChemmolrepraromaticNode, b : ChemmolrepraromaticNode) -> ChemmolrepraromaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_node_copy(s : ChemmolrepraromaticNode) -> ChemmolrepraromaticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_node_fill(s : ChemmolrepraromaticNode, v : Double) -> ChemmolrepraromaticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_node_min(s : ChemmolrepraromaticNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_node_max(s : ChemmolrepraromaticNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_node_to_string(s : ChemmolrepraromaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_edge_make(size : Int) -> ChemmolrepraromaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_edge_len(s : ChemmolrepraromaticEdge) -> Int { s.size }

pub fn chem_mol_repr_aromatic_edge_get(s : ChemmolrepraromaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_edge_set(s : ChemmolrepraromaticEdge, i : Int, v : Double) -> ChemmolrepraromaticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_edge_sum(s : ChemmolrepraromaticEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_edge_mean(s : ChemmolrepraromaticEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_edge_scale(s : ChemmolrepraromaticEdge, f : Double) -> ChemmolrepraromaticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_edge_add(a : ChemmolrepraromaticEdge, b : ChemmolrepraromaticEdge) -> ChemmolrepraromaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_edge_copy(s : ChemmolrepraromaticEdge) -> ChemmolrepraromaticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_edge_fill(s : ChemmolrepraromaticEdge, v : Double) -> ChemmolrepraromaticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_edge_min(s : ChemmolrepraromaticEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_edge_max(s : ChemmolrepraromaticEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_edge_to_string(s : ChemmolrepraromaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_path_make(size : Int) -> ChemmolrepraromaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_path_len(s : ChemmolrepraromaticPath) -> Int { s.size }

pub fn chem_mol_repr_aromatic_path_get(s : ChemmolrepraromaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_path_set(s : ChemmolrepraromaticPath, i : Int, v : Double) -> ChemmolrepraromaticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_path_sum(s : ChemmolrepraromaticPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_path_mean(s : ChemmolrepraromaticPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_path_scale(s : ChemmolrepraromaticPath, f : Double) -> ChemmolrepraromaticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_path_add(a : ChemmolrepraromaticPath, b : ChemmolrepraromaticPath) -> ChemmolrepraromaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_path_copy(s : ChemmolrepraromaticPath) -> ChemmolrepraromaticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_path_fill(s : ChemmolrepraromaticPath, v : Double) -> ChemmolrepraromaticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_path_min(s : ChemmolrepraromaticPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_path_max(s : ChemmolrepraromaticPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_path_to_string(s : ChemmolrepraromaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_cluster_make(size : Int) -> ChemmolrepraromaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_cluster_len(s : ChemmolrepraromaticCluster) -> Int { s.size }

pub fn chem_mol_repr_aromatic_cluster_get(s : ChemmolrepraromaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_cluster_set(s : ChemmolrepraromaticCluster, i : Int, v : Double) -> ChemmolrepraromaticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cluster_sum(s : ChemmolrepraromaticCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_cluster_mean(s : ChemmolrepraromaticCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_cluster_scale(s : ChemmolrepraromaticCluster, f : Double) -> ChemmolrepraromaticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cluster_add(a : ChemmolrepraromaticCluster, b : ChemmolrepraromaticCluster) -> ChemmolrepraromaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_cluster_copy(s : ChemmolrepraromaticCluster) -> ChemmolrepraromaticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cluster_fill(s : ChemmolrepraromaticCluster, v : Double) -> ChemmolrepraromaticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cluster_min(s : ChemmolrepraromaticCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_cluster_max(s : ChemmolrepraromaticCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_cluster_to_string(s : ChemmolrepraromaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_model_make(size : Int) -> ChemmolrepraromaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_model_len(s : ChemmolrepraromaticModel) -> Int { s.size }

pub fn chem_mol_repr_aromatic_model_get(s : ChemmolrepraromaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_model_set(s : ChemmolrepraromaticModel, i : Int, v : Double) -> ChemmolrepraromaticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_model_sum(s : ChemmolrepraromaticModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_model_mean(s : ChemmolrepraromaticModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_model_scale(s : ChemmolrepraromaticModel, f : Double) -> ChemmolrepraromaticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_model_add(a : ChemmolrepraromaticModel, b : ChemmolrepraromaticModel) -> ChemmolrepraromaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_model_copy(s : ChemmolrepraromaticModel) -> ChemmolrepraromaticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_model_fill(s : ChemmolrepraromaticModel, v : Double) -> ChemmolrepraromaticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_model_min(s : ChemmolrepraromaticModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_model_max(s : ChemmolrepraromaticModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_model_to_string(s : ChemmolrepraromaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_layer_make(size : Int) -> ChemmolrepraromaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_layer_len(s : ChemmolrepraromaticLayer) -> Int { s.size }

pub fn chem_mol_repr_aromatic_layer_get(s : ChemmolrepraromaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_layer_set(s : ChemmolrepraromaticLayer, i : Int, v : Double) -> ChemmolrepraromaticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_layer_sum(s : ChemmolrepraromaticLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_layer_mean(s : ChemmolrepraromaticLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_layer_scale(s : ChemmolrepraromaticLayer, f : Double) -> ChemmolrepraromaticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_layer_add(a : ChemmolrepraromaticLayer, b : ChemmolrepraromaticLayer) -> ChemmolrepraromaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_layer_copy(s : ChemmolrepraromaticLayer) -> ChemmolrepraromaticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_layer_fill(s : ChemmolrepraromaticLayer, v : Double) -> ChemmolrepraromaticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_layer_min(s : ChemmolrepraromaticLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_layer_max(s : ChemmolrepraromaticLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_layer_to_string(s : ChemmolrepraromaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_buffer_make(size : Int) -> ChemmolrepraromaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_buffer_len(s : ChemmolrepraromaticBuffer) -> Int { s.size }

pub fn chem_mol_repr_aromatic_buffer_get(s : ChemmolrepraromaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_buffer_set(s : ChemmolrepraromaticBuffer, i : Int, v : Double) -> ChemmolrepraromaticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_buffer_sum(s : ChemmolrepraromaticBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_buffer_mean(s : ChemmolrepraromaticBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_buffer_scale(s : ChemmolrepraromaticBuffer, f : Double) -> ChemmolrepraromaticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_buffer_add(a : ChemmolrepraromaticBuffer, b : ChemmolrepraromaticBuffer) -> ChemmolrepraromaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_buffer_copy(s : ChemmolrepraromaticBuffer) -> ChemmolrepraromaticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_buffer_fill(s : ChemmolrepraromaticBuffer, v : Double) -> ChemmolrepraromaticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_buffer_min(s : ChemmolrepraromaticBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_buffer_max(s : ChemmolrepraromaticBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_buffer_to_string(s : ChemmolrepraromaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_cursor_make(size : Int) -> ChemmolrepraromaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_cursor_len(s : ChemmolrepraromaticCursor) -> Int { s.size }

pub fn chem_mol_repr_aromatic_cursor_get(s : ChemmolrepraromaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_cursor_set(s : ChemmolrepraromaticCursor, i : Int, v : Double) -> ChemmolrepraromaticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cursor_sum(s : ChemmolrepraromaticCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_cursor_mean(s : ChemmolrepraromaticCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_cursor_scale(s : ChemmolrepraromaticCursor, f : Double) -> ChemmolrepraromaticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cursor_add(a : ChemmolrepraromaticCursor, b : ChemmolrepraromaticCursor) -> ChemmolrepraromaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_cursor_copy(s : ChemmolrepraromaticCursor) -> ChemmolrepraromaticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cursor_fill(s : ChemmolrepraromaticCursor, v : Double) -> ChemmolrepraromaticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cursor_min(s : ChemmolrepraromaticCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_cursor_max(s : ChemmolrepraromaticCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_cursor_to_string(s : ChemmolrepraromaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_view_make(size : Int) -> ChemmolrepraromaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_view_len(s : ChemmolrepraromaticView) -> Int { s.size }

pub fn chem_mol_repr_aromatic_view_get(s : ChemmolrepraromaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_view_set(s : ChemmolrepraromaticView, i : Int, v : Double) -> ChemmolrepraromaticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_view_sum(s : ChemmolrepraromaticView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_view_mean(s : ChemmolrepraromaticView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_view_scale(s : ChemmolrepraromaticView, f : Double) -> ChemmolrepraromaticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_view_add(a : ChemmolrepraromaticView, b : ChemmolrepraromaticView) -> ChemmolrepraromaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_view_copy(s : ChemmolrepraromaticView) -> ChemmolrepraromaticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_view_fill(s : ChemmolrepraromaticView, v : Double) -> ChemmolrepraromaticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_view_min(s : ChemmolrepraromaticView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_view_max(s : ChemmolrepraromaticView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_view_to_string(s : ChemmolrepraromaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_range_make(size : Int) -> ChemmolrepraromaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_range_len(s : ChemmolrepraromaticRange) -> Int { s.size }

pub fn chem_mol_repr_aromatic_range_get(s : ChemmolrepraromaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_range_set(s : ChemmolrepraromaticRange, i : Int, v : Double) -> ChemmolrepraromaticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_range_sum(s : ChemmolrepraromaticRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_range_mean(s : ChemmolrepraromaticRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_range_scale(s : ChemmolrepraromaticRange, f : Double) -> ChemmolrepraromaticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_range_add(a : ChemmolrepraromaticRange, b : ChemmolrepraromaticRange) -> ChemmolrepraromaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_range_copy(s : ChemmolrepraromaticRange) -> ChemmolrepraromaticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_range_fill(s : ChemmolrepraromaticRange, v : Double) -> ChemmolrepraromaticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_range_min(s : ChemmolrepraromaticRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_range_max(s : ChemmolrepraromaticRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_range_to_string(s : ChemmolrepraromaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_slice_make(size : Int) -> ChemmolrepraromaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_slice_len(s : ChemmolrepraromaticSlice) -> Int { s.size }

pub fn chem_mol_repr_aromatic_slice_get(s : ChemmolrepraromaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_slice_set(s : ChemmolrepraromaticSlice, i : Int, v : Double) -> ChemmolrepraromaticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_slice_sum(s : ChemmolrepraromaticSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_slice_mean(s : ChemmolrepraromaticSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_slice_scale(s : ChemmolrepraromaticSlice, f : Double) -> ChemmolrepraromaticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_slice_add(a : ChemmolrepraromaticSlice, b : ChemmolrepraromaticSlice) -> ChemmolrepraromaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_slice_copy(s : ChemmolrepraromaticSlice) -> ChemmolrepraromaticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_slice_fill(s : ChemmolrepraromaticSlice, v : Double) -> ChemmolrepraromaticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_slice_min(s : ChemmolrepraromaticSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_slice_max(s : ChemmolrepraromaticSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_slice_to_string(s : ChemmolrepraromaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

