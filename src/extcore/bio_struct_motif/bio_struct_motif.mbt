///===
/// extcore/bio_struct_motif

pub(all) struct BiostructmotifPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_motif_make_point(x : Double, y : Double) -> BiostructmotifPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_motif_make_point3(x : Double, y : Double, z : Double) -> BiostructmotifPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructmotifPoint::x(self : BiostructmotifPoint) -> Double { self.x }

pub fn BiostructmotifPoint::y(self : BiostructmotifPoint) -> Double { self.y }

pub fn BiostructmotifPoint::z(self : BiostructmotifPoint) -> Double { self.z }

pub fn BiostructmotifPoint::label(self : BiostructmotifPoint) -> Int { self.label }

pub fn BiostructmotifPoint::dist(self : BiostructmotifPoint, other : BiostructmotifPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructmotifPoint::add(self : BiostructmotifPoint, other : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructmotifPoint::sub(self : BiostructmotifPoint, other : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructmotifPoint::scale(self : BiostructmotifPoint, s : Double) -> BiostructmotifPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructmotifPoint::dot(self : BiostructmotifPoint, other : BiostructmotifPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructmotifPoint::cross(self : BiostructmotifPoint, other : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructmotifPoint::norm(self : BiostructmotifPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructmotifPoint::normalize(self : BiostructmotifPoint) -> BiostructmotifPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructmotifPoint::negate(self : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructmotifPoint::mid(self : BiostructmotifPoint, other : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructmotifPoint::lerp(self : BiostructmotifPoint, other : BiostructmotifPoint, t : Double) -> BiostructmotifPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructmotifPoint::to_string(self : BiostructmotifPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructmotifSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_motif_make_series(vals : Array[Double], name : String) -> BiostructmotifSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructmotifSeries::len(self : BiostructmotifSeries) -> Int { self.vals.length() }

pub fn BiostructmotifSeries::sum(self : BiostructmotifSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructmotifSeries::mean(self : BiostructmotifSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructmotifSeries::min(self : BiostructmotifSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructmotifSeries::max(self : BiostructmotifSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructmotifSeries::range(self : BiostructmotifSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructmotifSeries::variance(self : BiostructmotifSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructmotifSeries::std(self : BiostructmotifSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructmotifSeries::median(self : BiostructmotifSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructmotifSeries::scale(self : BiostructmotifSeries, f : Double) -> BiostructmotifSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructmotifSeries::add(self : BiostructmotifSeries, other : BiostructmotifSeries) -> BiostructmotifSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructmotifSeries::sub(self : BiostructmotifSeries, other : BiostructmotifSeries) -> BiostructmotifSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructmotifSeries::normalize(self : BiostructmotifSeries) -> BiostructmotifSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructmotifSeries::cumsum(self : BiostructmotifSeries) -> BiostructmotifSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructmotifSeries::to_string(self : BiostructmotifSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructmotifMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_motif_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructmotifMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_motif_matrix_identity(n : Int) -> BiostructmotifMatrix {
  let m = bio_struct_motif_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructmotifMatrix::get(self : BiostructmotifMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructmotifMatrix::transpose(self : BiostructmotifMatrix) -> BiostructmotifMatrix {
  let result = bio_struct_motif_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructmotifMatrix::add(self : BiostructmotifMatrix, other : BiostructmotifMatrix) -> BiostructmotifMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_motif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructmotifMatrix::scale(self : BiostructmotifMatrix, s : Double) -> BiostructmotifMatrix {
  let result = bio_struct_motif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructmotifMatrix::multiply(self : BiostructmotifMatrix, other : BiostructmotifMatrix) -> BiostructmotifMatrix {
  if self.cols != other.rows { return bio_struct_motif_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_motif_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructmotifMatrix::trace(self : BiostructmotifMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructmotifMatrix::det(self : BiostructmotifMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructmotifMatrix::norm(self : BiostructmotifMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructmotifMatrix::to_string(self : BiostructmotifMatrix) -> String {
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

pub(all) struct BiostructmotifVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_motif_make_vector(comps : Array[Double]) -> BiostructmotifVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_motif_vector_zero(dim : Int) -> BiostructmotifVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructmotifVector::add(self : BiostructmotifVector, other : BiostructmotifVector) -> BiostructmotifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructmotifVector::sub(self : BiostructmotifVector, other : BiostructmotifVector) -> BiostructmotifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructmotifVector::scale(self : BiostructmotifVector, s : Double) -> BiostructmotifVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructmotifVector::dot(self : BiostructmotifVector, other : BiostructmotifVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructmotifVector::norm(self : BiostructmotifVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructmotifVector::normalize(self : BiostructmotifVector) -> BiostructmotifVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructmotifVector::dist(self : BiostructmotifVector, other : BiostructmotifVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructmotifVector::to_string(self : BiostructmotifVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_motif_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_motif_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_motif_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_motif_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_motif_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_motif_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_motif_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_motif_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_motif_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_motif_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_motif_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_motif_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_motif_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_motif_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_motif_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_motif_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_motif_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_motif_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_motif_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_motif_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_motif_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_motif_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_motif_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_motif_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_motif_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_motif_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_motif_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_motif_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_motif_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructmotifFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_frame_make(size : Int) -> BiostructmotifFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_frame_len(s : BiostructmotifFrame) -> Int { s.size }

pub fn bio_struct_motif_frame_get(s : BiostructmotifFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_frame_set(s : BiostructmotifFrame, i : Int, v : Double) -> BiostructmotifFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_sum(s : BiostructmotifFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_frame_mean(s : BiostructmotifFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_frame_scale(s : BiostructmotifFrame, f : Double) -> BiostructmotifFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_add(a : BiostructmotifFrame, b : BiostructmotifFrame) -> BiostructmotifFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_frame_copy(s : BiostructmotifFrame) -> BiostructmotifFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_fill(s : BiostructmotifFrame, v : Double) -> BiostructmotifFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_min(s : BiostructmotifFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_frame_max(s : BiostructmotifFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_frame_to_string(s : BiostructmotifFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_table_make(size : Int) -> BiostructmotifTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_table_len(s : BiostructmotifTable) -> Int { s.size }

pub fn bio_struct_motif_table_get(s : BiostructmotifTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_table_set(s : BiostructmotifTable, i : Int, v : Double) -> BiostructmotifTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_sum(s : BiostructmotifTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_table_mean(s : BiostructmotifTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_table_scale(s : BiostructmotifTable, f : Double) -> BiostructmotifTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_add(a : BiostructmotifTable, b : BiostructmotifTable) -> BiostructmotifTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_table_copy(s : BiostructmotifTable) -> BiostructmotifTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_fill(s : BiostructmotifTable, v : Double) -> BiostructmotifTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_min(s : BiostructmotifTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_table_max(s : BiostructmotifTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_table_to_string(s : BiostructmotifTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_graphn_make(size : Int) -> BiostructmotifGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_graphn_len(s : BiostructmotifGraphN) -> Int { s.size }

pub fn bio_struct_motif_graphn_get(s : BiostructmotifGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_graphn_set(s : BiostructmotifGraphN, i : Int, v : Double) -> BiostructmotifGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_sum(s : BiostructmotifGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_graphn_mean(s : BiostructmotifGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_graphn_scale(s : BiostructmotifGraphN, f : Double) -> BiostructmotifGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_add(a : BiostructmotifGraphN, b : BiostructmotifGraphN) -> BiostructmotifGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_graphn_copy(s : BiostructmotifGraphN) -> BiostructmotifGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_fill(s : BiostructmotifGraphN, v : Double) -> BiostructmotifGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_min(s : BiostructmotifGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_graphn_max(s : BiostructmotifGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_graphn_to_string(s : BiostructmotifGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_node_make(size : Int) -> BiostructmotifNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_node_len(s : BiostructmotifNode) -> Int { s.size }

pub fn bio_struct_motif_node_get(s : BiostructmotifNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_node_set(s : BiostructmotifNode, i : Int, v : Double) -> BiostructmotifNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_sum(s : BiostructmotifNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_node_mean(s : BiostructmotifNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_node_scale(s : BiostructmotifNode, f : Double) -> BiostructmotifNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_add(a : BiostructmotifNode, b : BiostructmotifNode) -> BiostructmotifNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_node_copy(s : BiostructmotifNode) -> BiostructmotifNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_fill(s : BiostructmotifNode, v : Double) -> BiostructmotifNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_min(s : BiostructmotifNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_node_max(s : BiostructmotifNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_node_to_string(s : BiostructmotifNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_edge_make(size : Int) -> BiostructmotifEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_edge_len(s : BiostructmotifEdge) -> Int { s.size }

pub fn bio_struct_motif_edge_get(s : BiostructmotifEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_edge_set(s : BiostructmotifEdge, i : Int, v : Double) -> BiostructmotifEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_sum(s : BiostructmotifEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_edge_mean(s : BiostructmotifEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_edge_scale(s : BiostructmotifEdge, f : Double) -> BiostructmotifEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_add(a : BiostructmotifEdge, b : BiostructmotifEdge) -> BiostructmotifEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_edge_copy(s : BiostructmotifEdge) -> BiostructmotifEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_fill(s : BiostructmotifEdge, v : Double) -> BiostructmotifEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_min(s : BiostructmotifEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_edge_max(s : BiostructmotifEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_edge_to_string(s : BiostructmotifEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_path_make(size : Int) -> BiostructmotifPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_path_len(s : BiostructmotifPath) -> Int { s.size }

pub fn bio_struct_motif_path_get(s : BiostructmotifPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_path_set(s : BiostructmotifPath, i : Int, v : Double) -> BiostructmotifPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_sum(s : BiostructmotifPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_path_mean(s : BiostructmotifPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_path_scale(s : BiostructmotifPath, f : Double) -> BiostructmotifPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_add(a : BiostructmotifPath, b : BiostructmotifPath) -> BiostructmotifPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_path_copy(s : BiostructmotifPath) -> BiostructmotifPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_fill(s : BiostructmotifPath, v : Double) -> BiostructmotifPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_min(s : BiostructmotifPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_path_max(s : BiostructmotifPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_path_to_string(s : BiostructmotifPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_cluster_make(size : Int) -> BiostructmotifCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_cluster_len(s : BiostructmotifCluster) -> Int { s.size }

pub fn bio_struct_motif_cluster_get(s : BiostructmotifCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_cluster_set(s : BiostructmotifCluster, i : Int, v : Double) -> BiostructmotifCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_sum(s : BiostructmotifCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_cluster_mean(s : BiostructmotifCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_cluster_scale(s : BiostructmotifCluster, f : Double) -> BiostructmotifCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_add(a : BiostructmotifCluster, b : BiostructmotifCluster) -> BiostructmotifCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_cluster_copy(s : BiostructmotifCluster) -> BiostructmotifCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_fill(s : BiostructmotifCluster, v : Double) -> BiostructmotifCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_min(s : BiostructmotifCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_cluster_max(s : BiostructmotifCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_cluster_to_string(s : BiostructmotifCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_model_make(size : Int) -> BiostructmotifModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_model_len(s : BiostructmotifModel) -> Int { s.size }

pub fn bio_struct_motif_model_get(s : BiostructmotifModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_model_set(s : BiostructmotifModel, i : Int, v : Double) -> BiostructmotifModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_sum(s : BiostructmotifModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_model_mean(s : BiostructmotifModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_model_scale(s : BiostructmotifModel, f : Double) -> BiostructmotifModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_add(a : BiostructmotifModel, b : BiostructmotifModel) -> BiostructmotifModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_model_copy(s : BiostructmotifModel) -> BiostructmotifModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_fill(s : BiostructmotifModel, v : Double) -> BiostructmotifModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_min(s : BiostructmotifModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_model_max(s : BiostructmotifModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_model_to_string(s : BiostructmotifModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_layer_make(size : Int) -> BiostructmotifLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_layer_len(s : BiostructmotifLayer) -> Int { s.size }

pub fn bio_struct_motif_layer_get(s : BiostructmotifLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_layer_set(s : BiostructmotifLayer, i : Int, v : Double) -> BiostructmotifLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_sum(s : BiostructmotifLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_layer_mean(s : BiostructmotifLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_layer_scale(s : BiostructmotifLayer, f : Double) -> BiostructmotifLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_add(a : BiostructmotifLayer, b : BiostructmotifLayer) -> BiostructmotifLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_layer_copy(s : BiostructmotifLayer) -> BiostructmotifLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_fill(s : BiostructmotifLayer, v : Double) -> BiostructmotifLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_min(s : BiostructmotifLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_layer_max(s : BiostructmotifLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_layer_to_string(s : BiostructmotifLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_buffer_make(size : Int) -> BiostructmotifBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_buffer_len(s : BiostructmotifBuffer) -> Int { s.size }

pub fn bio_struct_motif_buffer_get(s : BiostructmotifBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_buffer_set(s : BiostructmotifBuffer, i : Int, v : Double) -> BiostructmotifBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_sum(s : BiostructmotifBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_buffer_mean(s : BiostructmotifBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_buffer_scale(s : BiostructmotifBuffer, f : Double) -> BiostructmotifBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_add(a : BiostructmotifBuffer, b : BiostructmotifBuffer) -> BiostructmotifBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_buffer_copy(s : BiostructmotifBuffer) -> BiostructmotifBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_fill(s : BiostructmotifBuffer, v : Double) -> BiostructmotifBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_min(s : BiostructmotifBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_buffer_max(s : BiostructmotifBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_buffer_to_string(s : BiostructmotifBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_cursor_make(size : Int) -> BiostructmotifCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_cursor_len(s : BiostructmotifCursor) -> Int { s.size }

pub fn bio_struct_motif_cursor_get(s : BiostructmotifCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_cursor_set(s : BiostructmotifCursor, i : Int, v : Double) -> BiostructmotifCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_sum(s : BiostructmotifCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_cursor_mean(s : BiostructmotifCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_cursor_scale(s : BiostructmotifCursor, f : Double) -> BiostructmotifCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_add(a : BiostructmotifCursor, b : BiostructmotifCursor) -> BiostructmotifCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_cursor_copy(s : BiostructmotifCursor) -> BiostructmotifCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_fill(s : BiostructmotifCursor, v : Double) -> BiostructmotifCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_min(s : BiostructmotifCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_cursor_max(s : BiostructmotifCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_cursor_to_string(s : BiostructmotifCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_view_make(size : Int) -> BiostructmotifView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_view_len(s : BiostructmotifView) -> Int { s.size }

pub fn bio_struct_motif_view_get(s : BiostructmotifView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_view_set(s : BiostructmotifView, i : Int, v : Double) -> BiostructmotifView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_sum(s : BiostructmotifView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_view_mean(s : BiostructmotifView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_view_scale(s : BiostructmotifView, f : Double) -> BiostructmotifView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_add(a : BiostructmotifView, b : BiostructmotifView) -> BiostructmotifView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_view_copy(s : BiostructmotifView) -> BiostructmotifView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_fill(s : BiostructmotifView, v : Double) -> BiostructmotifView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_min(s : BiostructmotifView) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_view_max(s : BiostructmotifView) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_view_to_string(s : BiostructmotifView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_range_make(size : Int) -> BiostructmotifRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_range_len(s : BiostructmotifRange) -> Int { s.size }

pub fn bio_struct_motif_range_get(s : BiostructmotifRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_range_set(s : BiostructmotifRange, i : Int, v : Double) -> BiostructmotifRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_sum(s : BiostructmotifRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_range_mean(s : BiostructmotifRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_range_scale(s : BiostructmotifRange, f : Double) -> BiostructmotifRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_add(a : BiostructmotifRange, b : BiostructmotifRange) -> BiostructmotifRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_range_copy(s : BiostructmotifRange) -> BiostructmotifRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_fill(s : BiostructmotifRange, v : Double) -> BiostructmotifRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_min(s : BiostructmotifRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_range_max(s : BiostructmotifRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_range_to_string(s : BiostructmotifRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_slice_make(size : Int) -> BiostructmotifSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_slice_len(s : BiostructmotifSlice) -> Int { s.size }

pub fn bio_struct_motif_slice_get(s : BiostructmotifSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_slice_set(s : BiostructmotifSlice, i : Int, v : Double) -> BiostructmotifSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_sum(s : BiostructmotifSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_slice_mean(s : BiostructmotifSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_slice_scale(s : BiostructmotifSlice, f : Double) -> BiostructmotifSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_add(a : BiostructmotifSlice, b : BiostructmotifSlice) -> BiostructmotifSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_slice_copy(s : BiostructmotifSlice) -> BiostructmotifSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_fill(s : BiostructmotifSlice, v : Double) -> BiostructmotifSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_min(s : BiostructmotifSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_slice_max(s : BiostructmotifSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_slice_to_string(s : BiostructmotifSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

