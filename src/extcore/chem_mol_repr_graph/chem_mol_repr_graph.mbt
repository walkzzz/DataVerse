///===
/// extcore/chem_mol_repr_graph

pub(all) struct ChemmolreprgraphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_graph_make_point(x : Double, y : Double) -> ChemmolreprgraphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_graph_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprgraphPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprgraphPoint::x(self : ChemmolreprgraphPoint) -> Double { self.x }

pub fn ChemmolreprgraphPoint::y(self : ChemmolreprgraphPoint) -> Double { self.y }

pub fn ChemmolreprgraphPoint::z(self : ChemmolreprgraphPoint) -> Double { self.z }

pub fn ChemmolreprgraphPoint::label(self : ChemmolreprgraphPoint) -> Int { self.label }

pub fn ChemmolreprgraphPoint::dist(self : ChemmolreprgraphPoint, other : ChemmolreprgraphPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprgraphPoint::add(self : ChemmolreprgraphPoint, other : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprgraphPoint::sub(self : ChemmolreprgraphPoint, other : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprgraphPoint::scale(self : ChemmolreprgraphPoint, s : Double) -> ChemmolreprgraphPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprgraphPoint::dot(self : ChemmolreprgraphPoint, other : ChemmolreprgraphPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprgraphPoint::cross(self : ChemmolreprgraphPoint, other : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprgraphPoint::norm(self : ChemmolreprgraphPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprgraphPoint::normalize(self : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprgraphPoint::negate(self : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprgraphPoint::mid(self : ChemmolreprgraphPoint, other : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprgraphPoint::lerp(self : ChemmolreprgraphPoint, other : ChemmolreprgraphPoint, t : Double) -> ChemmolreprgraphPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprgraphPoint::to_string(self : ChemmolreprgraphPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprgraphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_graph_make_series(vals : Array[Double], name : String) -> ChemmolreprgraphSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprgraphSeries::len(self : ChemmolreprgraphSeries) -> Int { self.vals.length() }

pub fn ChemmolreprgraphSeries::sum(self : ChemmolreprgraphSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprgraphSeries::mean(self : ChemmolreprgraphSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprgraphSeries::min(self : ChemmolreprgraphSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprgraphSeries::max(self : ChemmolreprgraphSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprgraphSeries::range(self : ChemmolreprgraphSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprgraphSeries::variance(self : ChemmolreprgraphSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprgraphSeries::std(self : ChemmolreprgraphSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprgraphSeries::median(self : ChemmolreprgraphSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprgraphSeries::scale(self : ChemmolreprgraphSeries, f : Double) -> ChemmolreprgraphSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprgraphSeries::add(self : ChemmolreprgraphSeries, other : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprgraphSeries::sub(self : ChemmolreprgraphSeries, other : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprgraphSeries::normalize(self : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprgraphSeries::cumsum(self : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprgraphSeries::to_string(self : ChemmolreprgraphSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprgraphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_graph_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprgraphMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_graph_matrix_identity(n : Int) -> ChemmolreprgraphMatrix {
  let m = chem_mol_repr_graph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprgraphMatrix::get(self : ChemmolreprgraphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprgraphMatrix::transpose(self : ChemmolreprgraphMatrix) -> ChemmolreprgraphMatrix {
  let result = chem_mol_repr_graph_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprgraphMatrix::add(self : ChemmolreprgraphMatrix, other : ChemmolreprgraphMatrix) -> ChemmolreprgraphMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprgraphMatrix::scale(self : ChemmolreprgraphMatrix, s : Double) -> ChemmolreprgraphMatrix {
  let result = chem_mol_repr_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprgraphMatrix::multiply(self : ChemmolreprgraphMatrix, other : ChemmolreprgraphMatrix) -> ChemmolreprgraphMatrix {
  if self.cols != other.rows { return chem_mol_repr_graph_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_graph_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprgraphMatrix::trace(self : ChemmolreprgraphMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprgraphMatrix::det(self : ChemmolreprgraphMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprgraphMatrix::norm(self : ChemmolreprgraphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprgraphMatrix::to_string(self : ChemmolreprgraphMatrix) -> String {
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

pub(all) struct ChemmolreprgraphVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_graph_make_vector(comps : Array[Double]) -> ChemmolreprgraphVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_graph_vector_zero(dim : Int) -> ChemmolreprgraphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprgraphVector::add(self : ChemmolreprgraphVector, other : ChemmolreprgraphVector) -> ChemmolreprgraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprgraphVector::sub(self : ChemmolreprgraphVector, other : ChemmolreprgraphVector) -> ChemmolreprgraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprgraphVector::scale(self : ChemmolreprgraphVector, s : Double) -> ChemmolreprgraphVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprgraphVector::dot(self : ChemmolreprgraphVector, other : ChemmolreprgraphVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprgraphVector::norm(self : ChemmolreprgraphVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprgraphVector::normalize(self : ChemmolreprgraphVector) -> ChemmolreprgraphVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprgraphVector::dist(self : ChemmolreprgraphVector, other : ChemmolreprgraphVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprgraphVector::to_string(self : ChemmolreprgraphVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_graph_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_graph_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_graph_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_graph_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_graph_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_graph_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_graph_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_graph_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_graph_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_graph_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_graph_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_graph_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_graph_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_graph_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_graph_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_graph_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_graph_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_graph_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_graph_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_graph_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_graph_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_graph_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_graph_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_graph_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_graph_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_graph_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_graph_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_graph_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_graph_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprgraphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_frame_make(size : Int) -> ChemmolreprgraphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_frame_len(s : ChemmolreprgraphFrame) -> Int { s.size }

pub fn chem_mol_repr_graph_frame_get(s : ChemmolreprgraphFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_frame_set(s : ChemmolreprgraphFrame, i : Int, v : Double) -> ChemmolreprgraphFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_frame_sum(s : ChemmolreprgraphFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_frame_mean(s : ChemmolreprgraphFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_frame_scale(s : ChemmolreprgraphFrame, f : Double) -> ChemmolreprgraphFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_frame_add(a : ChemmolreprgraphFrame, b : ChemmolreprgraphFrame) -> ChemmolreprgraphFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_frame_copy(s : ChemmolreprgraphFrame) -> ChemmolreprgraphFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_frame_fill(s : ChemmolreprgraphFrame, v : Double) -> ChemmolreprgraphFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_frame_min(s : ChemmolreprgraphFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_frame_max(s : ChemmolreprgraphFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_frame_to_string(s : ChemmolreprgraphFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_table_make(size : Int) -> ChemmolreprgraphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_table_len(s : ChemmolreprgraphTable) -> Int { s.size }

pub fn chem_mol_repr_graph_table_get(s : ChemmolreprgraphTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_table_set(s : ChemmolreprgraphTable, i : Int, v : Double) -> ChemmolreprgraphTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_table_sum(s : ChemmolreprgraphTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_table_mean(s : ChemmolreprgraphTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_table_scale(s : ChemmolreprgraphTable, f : Double) -> ChemmolreprgraphTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_table_add(a : ChemmolreprgraphTable, b : ChemmolreprgraphTable) -> ChemmolreprgraphTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_table_copy(s : ChemmolreprgraphTable) -> ChemmolreprgraphTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_table_fill(s : ChemmolreprgraphTable, v : Double) -> ChemmolreprgraphTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_table_min(s : ChemmolreprgraphTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_table_max(s : ChemmolreprgraphTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_table_to_string(s : ChemmolreprgraphTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_graphn_make(size : Int) -> ChemmolreprgraphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_graphn_len(s : ChemmolreprgraphGraphN) -> Int { s.size }

pub fn chem_mol_repr_graph_graphn_get(s : ChemmolreprgraphGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_graphn_set(s : ChemmolreprgraphGraphN, i : Int, v : Double) -> ChemmolreprgraphGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_graphn_sum(s : ChemmolreprgraphGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_graphn_mean(s : ChemmolreprgraphGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_graphn_scale(s : ChemmolreprgraphGraphN, f : Double) -> ChemmolreprgraphGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_graphn_add(a : ChemmolreprgraphGraphN, b : ChemmolreprgraphGraphN) -> ChemmolreprgraphGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_graphn_copy(s : ChemmolreprgraphGraphN) -> ChemmolreprgraphGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_graphn_fill(s : ChemmolreprgraphGraphN, v : Double) -> ChemmolreprgraphGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_graphn_min(s : ChemmolreprgraphGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_graphn_max(s : ChemmolreprgraphGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_graphn_to_string(s : ChemmolreprgraphGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_node_make(size : Int) -> ChemmolreprgraphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_node_len(s : ChemmolreprgraphNode) -> Int { s.size }

pub fn chem_mol_repr_graph_node_get(s : ChemmolreprgraphNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_node_set(s : ChemmolreprgraphNode, i : Int, v : Double) -> ChemmolreprgraphNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_node_sum(s : ChemmolreprgraphNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_node_mean(s : ChemmolreprgraphNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_node_scale(s : ChemmolreprgraphNode, f : Double) -> ChemmolreprgraphNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_node_add(a : ChemmolreprgraphNode, b : ChemmolreprgraphNode) -> ChemmolreprgraphNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_node_copy(s : ChemmolreprgraphNode) -> ChemmolreprgraphNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_node_fill(s : ChemmolreprgraphNode, v : Double) -> ChemmolreprgraphNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_node_min(s : ChemmolreprgraphNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_node_max(s : ChemmolreprgraphNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_node_to_string(s : ChemmolreprgraphNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_edge_make(size : Int) -> ChemmolreprgraphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_edge_len(s : ChemmolreprgraphEdge) -> Int { s.size }

pub fn chem_mol_repr_graph_edge_get(s : ChemmolreprgraphEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_edge_set(s : ChemmolreprgraphEdge, i : Int, v : Double) -> ChemmolreprgraphEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_edge_sum(s : ChemmolreprgraphEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_edge_mean(s : ChemmolreprgraphEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_edge_scale(s : ChemmolreprgraphEdge, f : Double) -> ChemmolreprgraphEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_edge_add(a : ChemmolreprgraphEdge, b : ChemmolreprgraphEdge) -> ChemmolreprgraphEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_edge_copy(s : ChemmolreprgraphEdge) -> ChemmolreprgraphEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_edge_fill(s : ChemmolreprgraphEdge, v : Double) -> ChemmolreprgraphEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_edge_min(s : ChemmolreprgraphEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_edge_max(s : ChemmolreprgraphEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_edge_to_string(s : ChemmolreprgraphEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_path_make(size : Int) -> ChemmolreprgraphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_path_len(s : ChemmolreprgraphPath) -> Int { s.size }

pub fn chem_mol_repr_graph_path_get(s : ChemmolreprgraphPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_path_set(s : ChemmolreprgraphPath, i : Int, v : Double) -> ChemmolreprgraphPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_path_sum(s : ChemmolreprgraphPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_path_mean(s : ChemmolreprgraphPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_path_scale(s : ChemmolreprgraphPath, f : Double) -> ChemmolreprgraphPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_path_add(a : ChemmolreprgraphPath, b : ChemmolreprgraphPath) -> ChemmolreprgraphPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_path_copy(s : ChemmolreprgraphPath) -> ChemmolreprgraphPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_path_fill(s : ChemmolreprgraphPath, v : Double) -> ChemmolreprgraphPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_path_min(s : ChemmolreprgraphPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_path_max(s : ChemmolreprgraphPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_path_to_string(s : ChemmolreprgraphPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_cluster_make(size : Int) -> ChemmolreprgraphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_cluster_len(s : ChemmolreprgraphCluster) -> Int { s.size }

pub fn chem_mol_repr_graph_cluster_get(s : ChemmolreprgraphCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_cluster_set(s : ChemmolreprgraphCluster, i : Int, v : Double) -> ChemmolreprgraphCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cluster_sum(s : ChemmolreprgraphCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_cluster_mean(s : ChemmolreprgraphCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_cluster_scale(s : ChemmolreprgraphCluster, f : Double) -> ChemmolreprgraphCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cluster_add(a : ChemmolreprgraphCluster, b : ChemmolreprgraphCluster) -> ChemmolreprgraphCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_cluster_copy(s : ChemmolreprgraphCluster) -> ChemmolreprgraphCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cluster_fill(s : ChemmolreprgraphCluster, v : Double) -> ChemmolreprgraphCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cluster_min(s : ChemmolreprgraphCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_cluster_max(s : ChemmolreprgraphCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_cluster_to_string(s : ChemmolreprgraphCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_model_make(size : Int) -> ChemmolreprgraphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_model_len(s : ChemmolreprgraphModel) -> Int { s.size }

pub fn chem_mol_repr_graph_model_get(s : ChemmolreprgraphModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_model_set(s : ChemmolreprgraphModel, i : Int, v : Double) -> ChemmolreprgraphModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_model_sum(s : ChemmolreprgraphModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_model_mean(s : ChemmolreprgraphModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_model_scale(s : ChemmolreprgraphModel, f : Double) -> ChemmolreprgraphModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_model_add(a : ChemmolreprgraphModel, b : ChemmolreprgraphModel) -> ChemmolreprgraphModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_model_copy(s : ChemmolreprgraphModel) -> ChemmolreprgraphModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_model_fill(s : ChemmolreprgraphModel, v : Double) -> ChemmolreprgraphModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_model_min(s : ChemmolreprgraphModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_model_max(s : ChemmolreprgraphModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_model_to_string(s : ChemmolreprgraphModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_layer_make(size : Int) -> ChemmolreprgraphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_layer_len(s : ChemmolreprgraphLayer) -> Int { s.size }

pub fn chem_mol_repr_graph_layer_get(s : ChemmolreprgraphLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_layer_set(s : ChemmolreprgraphLayer, i : Int, v : Double) -> ChemmolreprgraphLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_layer_sum(s : ChemmolreprgraphLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_layer_mean(s : ChemmolreprgraphLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_layer_scale(s : ChemmolreprgraphLayer, f : Double) -> ChemmolreprgraphLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_layer_add(a : ChemmolreprgraphLayer, b : ChemmolreprgraphLayer) -> ChemmolreprgraphLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_layer_copy(s : ChemmolreprgraphLayer) -> ChemmolreprgraphLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_layer_fill(s : ChemmolreprgraphLayer, v : Double) -> ChemmolreprgraphLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_layer_min(s : ChemmolreprgraphLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_layer_max(s : ChemmolreprgraphLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_layer_to_string(s : ChemmolreprgraphLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_buffer_make(size : Int) -> ChemmolreprgraphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_buffer_len(s : ChemmolreprgraphBuffer) -> Int { s.size }

pub fn chem_mol_repr_graph_buffer_get(s : ChemmolreprgraphBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_buffer_set(s : ChemmolreprgraphBuffer, i : Int, v : Double) -> ChemmolreprgraphBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_buffer_sum(s : ChemmolreprgraphBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_buffer_mean(s : ChemmolreprgraphBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_buffer_scale(s : ChemmolreprgraphBuffer, f : Double) -> ChemmolreprgraphBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_buffer_add(a : ChemmolreprgraphBuffer, b : ChemmolreprgraphBuffer) -> ChemmolreprgraphBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_buffer_copy(s : ChemmolreprgraphBuffer) -> ChemmolreprgraphBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_buffer_fill(s : ChemmolreprgraphBuffer, v : Double) -> ChemmolreprgraphBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_buffer_min(s : ChemmolreprgraphBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_buffer_max(s : ChemmolreprgraphBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_buffer_to_string(s : ChemmolreprgraphBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_cursor_make(size : Int) -> ChemmolreprgraphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_cursor_len(s : ChemmolreprgraphCursor) -> Int { s.size }

pub fn chem_mol_repr_graph_cursor_get(s : ChemmolreprgraphCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_cursor_set(s : ChemmolreprgraphCursor, i : Int, v : Double) -> ChemmolreprgraphCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cursor_sum(s : ChemmolreprgraphCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_cursor_mean(s : ChemmolreprgraphCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_cursor_scale(s : ChemmolreprgraphCursor, f : Double) -> ChemmolreprgraphCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cursor_add(a : ChemmolreprgraphCursor, b : ChemmolreprgraphCursor) -> ChemmolreprgraphCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_cursor_copy(s : ChemmolreprgraphCursor) -> ChemmolreprgraphCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cursor_fill(s : ChemmolreprgraphCursor, v : Double) -> ChemmolreprgraphCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_cursor_min(s : ChemmolreprgraphCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_cursor_max(s : ChemmolreprgraphCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_cursor_to_string(s : ChemmolreprgraphCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_view_make(size : Int) -> ChemmolreprgraphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_view_len(s : ChemmolreprgraphView) -> Int { s.size }

pub fn chem_mol_repr_graph_view_get(s : ChemmolreprgraphView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_view_set(s : ChemmolreprgraphView, i : Int, v : Double) -> ChemmolreprgraphView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_view_sum(s : ChemmolreprgraphView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_view_mean(s : ChemmolreprgraphView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_view_scale(s : ChemmolreprgraphView, f : Double) -> ChemmolreprgraphView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_view_add(a : ChemmolreprgraphView, b : ChemmolreprgraphView) -> ChemmolreprgraphView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_view_copy(s : ChemmolreprgraphView) -> ChemmolreprgraphView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_view_fill(s : ChemmolreprgraphView, v : Double) -> ChemmolreprgraphView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_view_min(s : ChemmolreprgraphView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_view_max(s : ChemmolreprgraphView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_view_to_string(s : ChemmolreprgraphView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_range_make(size : Int) -> ChemmolreprgraphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_range_len(s : ChemmolreprgraphRange) -> Int { s.size }

pub fn chem_mol_repr_graph_range_get(s : ChemmolreprgraphRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_range_set(s : ChemmolreprgraphRange, i : Int, v : Double) -> ChemmolreprgraphRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_range_sum(s : ChemmolreprgraphRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_range_mean(s : ChemmolreprgraphRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_range_scale(s : ChemmolreprgraphRange, f : Double) -> ChemmolreprgraphRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_range_add(a : ChemmolreprgraphRange, b : ChemmolreprgraphRange) -> ChemmolreprgraphRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_range_copy(s : ChemmolreprgraphRange) -> ChemmolreprgraphRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_range_fill(s : ChemmolreprgraphRange, v : Double) -> ChemmolreprgraphRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_range_min(s : ChemmolreprgraphRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_range_max(s : ChemmolreprgraphRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_range_to_string(s : ChemmolreprgraphRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_slice_make(size : Int) -> ChemmolreprgraphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_slice_len(s : ChemmolreprgraphSlice) -> Int { s.size }

pub fn chem_mol_repr_graph_slice_get(s : ChemmolreprgraphSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_slice_set(s : ChemmolreprgraphSlice, i : Int, v : Double) -> ChemmolreprgraphSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_slice_sum(s : ChemmolreprgraphSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_graph_slice_mean(s : ChemmolreprgraphSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_graph_slice_scale(s : ChemmolreprgraphSlice, f : Double) -> ChemmolreprgraphSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_slice_add(a : ChemmolreprgraphSlice, b : ChemmolreprgraphSlice) -> ChemmolreprgraphSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_graph_slice_copy(s : ChemmolreprgraphSlice) -> ChemmolreprgraphSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_slice_fill(s : ChemmolreprgraphSlice, v : Double) -> ChemmolreprgraphSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_graph_slice_min(s : ChemmolreprgraphSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_graph_slice_max(s : ChemmolreprgraphSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_graph_slice_to_string(s : ChemmolreprgraphSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

