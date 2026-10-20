///===
/// extcore/chem_mol_repr_cif

pub(all) struct ChemmolreprcifPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_cif_make_point(x : Double, y : Double) -> ChemmolreprcifPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_cif_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprcifPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprcifPoint::x(self : ChemmolreprcifPoint) -> Double { self.x }

pub fn ChemmolreprcifPoint::y(self : ChemmolreprcifPoint) -> Double { self.y }

pub fn ChemmolreprcifPoint::z(self : ChemmolreprcifPoint) -> Double { self.z }

pub fn ChemmolreprcifPoint::label(self : ChemmolreprcifPoint) -> Int { self.label }

pub fn ChemmolreprcifPoint::dist(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprcifPoint::add(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprcifPoint::sub(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprcifPoint::scale(self : ChemmolreprcifPoint, s : Double) -> ChemmolreprcifPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprcifPoint::dot(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprcifPoint::cross(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprcifPoint::norm(self : ChemmolreprcifPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprcifPoint::normalize(self : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprcifPoint::negate(self : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprcifPoint::mid(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprcifPoint::lerp(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint, t : Double) -> ChemmolreprcifPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprcifPoint::to_string(self : ChemmolreprcifPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprcifSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_cif_make_series(vals : Array[Double], name : String) -> ChemmolreprcifSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprcifSeries::len(self : ChemmolreprcifSeries) -> Int { self.vals.length() }

pub fn ChemmolreprcifSeries::sum(self : ChemmolreprcifSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprcifSeries::mean(self : ChemmolreprcifSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprcifSeries::min(self : ChemmolreprcifSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprcifSeries::max(self : ChemmolreprcifSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprcifSeries::range(self : ChemmolreprcifSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprcifSeries::variance(self : ChemmolreprcifSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprcifSeries::std(self : ChemmolreprcifSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprcifSeries::median(self : ChemmolreprcifSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprcifSeries::scale(self : ChemmolreprcifSeries, f : Double) -> ChemmolreprcifSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprcifSeries::add(self : ChemmolreprcifSeries, other : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprcifSeries::sub(self : ChemmolreprcifSeries, other : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprcifSeries::normalize(self : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprcifSeries::cumsum(self : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprcifSeries::to_string(self : ChemmolreprcifSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprcifMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_cif_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprcifMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_cif_matrix_identity(n : Int) -> ChemmolreprcifMatrix {
  let m = chem_mol_repr_cif_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprcifMatrix::get(self : ChemmolreprcifMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprcifMatrix::transpose(self : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprcifMatrix::add(self : ChemmolreprcifMatrix, other : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_cif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprcifMatrix::scale(self : ChemmolreprcifMatrix, s : Double) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprcifMatrix::multiply(self : ChemmolreprcifMatrix, other : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if self.cols != other.rows { return chem_mol_repr_cif_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_cif_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprcifMatrix::trace(self : ChemmolreprcifMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprcifMatrix::det(self : ChemmolreprcifMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprcifMatrix::norm(self : ChemmolreprcifMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprcifMatrix::to_string(self : ChemmolreprcifMatrix) -> String {
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

pub(all) struct ChemmolreprcifVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_cif_make_vector(comps : Array[Double]) -> ChemmolreprcifVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_cif_vector_zero(dim : Int) -> ChemmolreprcifVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprcifVector::add(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprcifVector::sub(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprcifVector::scale(self : ChemmolreprcifVector, s : Double) -> ChemmolreprcifVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprcifVector::dot(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprcifVector::norm(self : ChemmolreprcifVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprcifVector::normalize(self : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprcifVector::dist(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprcifVector::to_string(self : ChemmolreprcifVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_cif_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_cif_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_cif_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_cif_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_cif_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_cif_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_cif_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_cif_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_cif_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_cif_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_cif_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_cif_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_cif_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_cif_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_cif_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_cif_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_cif_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_cif_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_cif_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_cif_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_cif_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_cif_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_cif_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_cif_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_cif_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_cif_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_cif_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_cif_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_cif_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprcifFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_frame_make(size : Int) -> ChemmolreprcifFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_frame_len(s : ChemmolreprcifFrame) -> Int { s.size }

pub fn chem_mol_repr_cif_frame_get(s : ChemmolreprcifFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_frame_set(s : ChemmolreprcifFrame, i : Int, v : Double) -> ChemmolreprcifFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_sum(s : ChemmolreprcifFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_frame_mean(s : ChemmolreprcifFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_frame_scale(s : ChemmolreprcifFrame, f : Double) -> ChemmolreprcifFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_add(a : ChemmolreprcifFrame, b : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_frame_copy(s : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_fill(s : ChemmolreprcifFrame, v : Double) -> ChemmolreprcifFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_min(s : ChemmolreprcifFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_frame_max(s : ChemmolreprcifFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_frame_to_string(s : ChemmolreprcifFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_table_make(size : Int) -> ChemmolreprcifTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_table_len(s : ChemmolreprcifTable) -> Int { s.size }

pub fn chem_mol_repr_cif_table_get(s : ChemmolreprcifTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_table_set(s : ChemmolreprcifTable, i : Int, v : Double) -> ChemmolreprcifTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_sum(s : ChemmolreprcifTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_table_mean(s : ChemmolreprcifTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_table_scale(s : ChemmolreprcifTable, f : Double) -> ChemmolreprcifTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_add(a : ChemmolreprcifTable, b : ChemmolreprcifTable) -> ChemmolreprcifTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_table_copy(s : ChemmolreprcifTable) -> ChemmolreprcifTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_fill(s : ChemmolreprcifTable, v : Double) -> ChemmolreprcifTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_min(s : ChemmolreprcifTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_table_max(s : ChemmolreprcifTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_table_to_string(s : ChemmolreprcifTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_graphn_make(size : Int) -> ChemmolreprcifGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_graphn_len(s : ChemmolreprcifGraphN) -> Int { s.size }

pub fn chem_mol_repr_cif_graphn_get(s : ChemmolreprcifGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_graphn_set(s : ChemmolreprcifGraphN, i : Int, v : Double) -> ChemmolreprcifGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_sum(s : ChemmolreprcifGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_graphn_mean(s : ChemmolreprcifGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_graphn_scale(s : ChemmolreprcifGraphN, f : Double) -> ChemmolreprcifGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_add(a : ChemmolreprcifGraphN, b : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_graphn_copy(s : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_fill(s : ChemmolreprcifGraphN, v : Double) -> ChemmolreprcifGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_min(s : ChemmolreprcifGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_graphn_max(s : ChemmolreprcifGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_graphn_to_string(s : ChemmolreprcifGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_node_make(size : Int) -> ChemmolreprcifNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_node_len(s : ChemmolreprcifNode) -> Int { s.size }

pub fn chem_mol_repr_cif_node_get(s : ChemmolreprcifNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_node_set(s : ChemmolreprcifNode, i : Int, v : Double) -> ChemmolreprcifNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_sum(s : ChemmolreprcifNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_node_mean(s : ChemmolreprcifNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_node_scale(s : ChemmolreprcifNode, f : Double) -> ChemmolreprcifNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_add(a : ChemmolreprcifNode, b : ChemmolreprcifNode) -> ChemmolreprcifNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_node_copy(s : ChemmolreprcifNode) -> ChemmolreprcifNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_fill(s : ChemmolreprcifNode, v : Double) -> ChemmolreprcifNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_min(s : ChemmolreprcifNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_node_max(s : ChemmolreprcifNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_node_to_string(s : ChemmolreprcifNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_edge_make(size : Int) -> ChemmolreprcifEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_edge_len(s : ChemmolreprcifEdge) -> Int { s.size }

pub fn chem_mol_repr_cif_edge_get(s : ChemmolreprcifEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_edge_set(s : ChemmolreprcifEdge, i : Int, v : Double) -> ChemmolreprcifEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_sum(s : ChemmolreprcifEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_edge_mean(s : ChemmolreprcifEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_edge_scale(s : ChemmolreprcifEdge, f : Double) -> ChemmolreprcifEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_add(a : ChemmolreprcifEdge, b : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_edge_copy(s : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_fill(s : ChemmolreprcifEdge, v : Double) -> ChemmolreprcifEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_min(s : ChemmolreprcifEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_edge_max(s : ChemmolreprcifEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_edge_to_string(s : ChemmolreprcifEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_path_make(size : Int) -> ChemmolreprcifPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_path_len(s : ChemmolreprcifPath) -> Int { s.size }

pub fn chem_mol_repr_cif_path_get(s : ChemmolreprcifPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_path_set(s : ChemmolreprcifPath, i : Int, v : Double) -> ChemmolreprcifPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_sum(s : ChemmolreprcifPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_path_mean(s : ChemmolreprcifPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_path_scale(s : ChemmolreprcifPath, f : Double) -> ChemmolreprcifPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_add(a : ChemmolreprcifPath, b : ChemmolreprcifPath) -> ChemmolreprcifPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_path_copy(s : ChemmolreprcifPath) -> ChemmolreprcifPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_fill(s : ChemmolreprcifPath, v : Double) -> ChemmolreprcifPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_min(s : ChemmolreprcifPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_path_max(s : ChemmolreprcifPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_path_to_string(s : ChemmolreprcifPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cluster_make(size : Int) -> ChemmolreprcifCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_cluster_len(s : ChemmolreprcifCluster) -> Int { s.size }

pub fn chem_mol_repr_cif_cluster_get(s : ChemmolreprcifCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_cluster_set(s : ChemmolreprcifCluster, i : Int, v : Double) -> ChemmolreprcifCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_sum(s : ChemmolreprcifCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_cluster_mean(s : ChemmolreprcifCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_cluster_scale(s : ChemmolreprcifCluster, f : Double) -> ChemmolreprcifCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_add(a : ChemmolreprcifCluster, b : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_cluster_copy(s : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_fill(s : ChemmolreprcifCluster, v : Double) -> ChemmolreprcifCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_min(s : ChemmolreprcifCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_cluster_max(s : ChemmolreprcifCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_cluster_to_string(s : ChemmolreprcifCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_model_make(size : Int) -> ChemmolreprcifModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_model_len(s : ChemmolreprcifModel) -> Int { s.size }

pub fn chem_mol_repr_cif_model_get(s : ChemmolreprcifModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_model_set(s : ChemmolreprcifModel, i : Int, v : Double) -> ChemmolreprcifModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_sum(s : ChemmolreprcifModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_model_mean(s : ChemmolreprcifModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_model_scale(s : ChemmolreprcifModel, f : Double) -> ChemmolreprcifModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_add(a : ChemmolreprcifModel, b : ChemmolreprcifModel) -> ChemmolreprcifModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_model_copy(s : ChemmolreprcifModel) -> ChemmolreprcifModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_fill(s : ChemmolreprcifModel, v : Double) -> ChemmolreprcifModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_min(s : ChemmolreprcifModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_model_max(s : ChemmolreprcifModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_model_to_string(s : ChemmolreprcifModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_layer_make(size : Int) -> ChemmolreprcifLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_layer_len(s : ChemmolreprcifLayer) -> Int { s.size }

pub fn chem_mol_repr_cif_layer_get(s : ChemmolreprcifLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_layer_set(s : ChemmolreprcifLayer, i : Int, v : Double) -> ChemmolreprcifLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_sum(s : ChemmolreprcifLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_layer_mean(s : ChemmolreprcifLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_layer_scale(s : ChemmolreprcifLayer, f : Double) -> ChemmolreprcifLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_add(a : ChemmolreprcifLayer, b : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_layer_copy(s : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_fill(s : ChemmolreprcifLayer, v : Double) -> ChemmolreprcifLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_min(s : ChemmolreprcifLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_layer_max(s : ChemmolreprcifLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_layer_to_string(s : ChemmolreprcifLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_buffer_make(size : Int) -> ChemmolreprcifBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_buffer_len(s : ChemmolreprcifBuffer) -> Int { s.size }

pub fn chem_mol_repr_cif_buffer_get(s : ChemmolreprcifBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_buffer_set(s : ChemmolreprcifBuffer, i : Int, v : Double) -> ChemmolreprcifBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_sum(s : ChemmolreprcifBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_buffer_mean(s : ChemmolreprcifBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_buffer_scale(s : ChemmolreprcifBuffer, f : Double) -> ChemmolreprcifBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_add(a : ChemmolreprcifBuffer, b : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_buffer_copy(s : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_fill(s : ChemmolreprcifBuffer, v : Double) -> ChemmolreprcifBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_min(s : ChemmolreprcifBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_buffer_max(s : ChemmolreprcifBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_buffer_to_string(s : ChemmolreprcifBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cursor_make(size : Int) -> ChemmolreprcifCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_cursor_len(s : ChemmolreprcifCursor) -> Int { s.size }

pub fn chem_mol_repr_cif_cursor_get(s : ChemmolreprcifCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_cursor_set(s : ChemmolreprcifCursor, i : Int, v : Double) -> ChemmolreprcifCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_sum(s : ChemmolreprcifCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_cursor_mean(s : ChemmolreprcifCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_cursor_scale(s : ChemmolreprcifCursor, f : Double) -> ChemmolreprcifCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_add(a : ChemmolreprcifCursor, b : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_cursor_copy(s : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_fill(s : ChemmolreprcifCursor, v : Double) -> ChemmolreprcifCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_min(s : ChemmolreprcifCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_cursor_max(s : ChemmolreprcifCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_cursor_to_string(s : ChemmolreprcifCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_view_make(size : Int) -> ChemmolreprcifView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_view_len(s : ChemmolreprcifView) -> Int { s.size }

pub fn chem_mol_repr_cif_view_get(s : ChemmolreprcifView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_view_set(s : ChemmolreprcifView, i : Int, v : Double) -> ChemmolreprcifView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_sum(s : ChemmolreprcifView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_view_mean(s : ChemmolreprcifView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_view_scale(s : ChemmolreprcifView, f : Double) -> ChemmolreprcifView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_add(a : ChemmolreprcifView, b : ChemmolreprcifView) -> ChemmolreprcifView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_view_copy(s : ChemmolreprcifView) -> ChemmolreprcifView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_fill(s : ChemmolreprcifView, v : Double) -> ChemmolreprcifView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_min(s : ChemmolreprcifView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_view_max(s : ChemmolreprcifView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_view_to_string(s : ChemmolreprcifView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_range_make(size : Int) -> ChemmolreprcifRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_range_len(s : ChemmolreprcifRange) -> Int { s.size }

pub fn chem_mol_repr_cif_range_get(s : ChemmolreprcifRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_range_set(s : ChemmolreprcifRange, i : Int, v : Double) -> ChemmolreprcifRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_sum(s : ChemmolreprcifRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_range_mean(s : ChemmolreprcifRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_range_scale(s : ChemmolreprcifRange, f : Double) -> ChemmolreprcifRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_add(a : ChemmolreprcifRange, b : ChemmolreprcifRange) -> ChemmolreprcifRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_range_copy(s : ChemmolreprcifRange) -> ChemmolreprcifRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_fill(s : ChemmolreprcifRange, v : Double) -> ChemmolreprcifRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_min(s : ChemmolreprcifRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_range_max(s : ChemmolreprcifRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_range_to_string(s : ChemmolreprcifRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_slice_make(size : Int) -> ChemmolreprcifSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_slice_len(s : ChemmolreprcifSlice) -> Int { s.size }

pub fn chem_mol_repr_cif_slice_get(s : ChemmolreprcifSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_slice_set(s : ChemmolreprcifSlice, i : Int, v : Double) -> ChemmolreprcifSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_sum(s : ChemmolreprcifSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_slice_mean(s : ChemmolreprcifSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_slice_scale(s : ChemmolreprcifSlice, f : Double) -> ChemmolreprcifSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_add(a : ChemmolreprcifSlice, b : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_slice_copy(s : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_fill(s : ChemmolreprcifSlice, v : Double) -> ChemmolreprcifSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_min(s : ChemmolreprcifSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_slice_max(s : ChemmolreprcifSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_slice_to_string(s : ChemmolreprcifSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

