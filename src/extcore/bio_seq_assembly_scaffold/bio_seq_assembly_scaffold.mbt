///===
/// extcore/bio_seq_assembly_scaffold

pub(all) struct BioseqassemblyscaffoldPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_scaffold_make_point(x : Double, y : Double) -> BioseqassemblyscaffoldPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_scaffold_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyscaffoldPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblyscaffoldPoint::x(self : BioseqassemblyscaffoldPoint) -> Double { self.x }

pub fn BioseqassemblyscaffoldPoint::y(self : BioseqassemblyscaffoldPoint) -> Double { self.y }

pub fn BioseqassemblyscaffoldPoint::z(self : BioseqassemblyscaffoldPoint) -> Double { self.z }

pub fn BioseqassemblyscaffoldPoint::label(self : BioseqassemblyscaffoldPoint) -> Int { self.label }

pub fn BioseqassemblyscaffoldPoint::dist(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblyscaffoldPoint::add(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::sub(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::scale(self : BioseqassemblyscaffoldPoint, s : Double) -> BioseqassemblyscaffoldPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::dot(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblyscaffoldPoint::cross(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblyscaffoldPoint::norm(self : BioseqassemblyscaffoldPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblyscaffoldPoint::normalize(self : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyscaffoldPoint::negate(self : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::mid(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::lerp(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint, t : Double) -> BioseqassemblyscaffoldPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::to_string(self : BioseqassemblyscaffoldPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_scaffold_make_series(vals : Array[Double], name : String) -> BioseqassemblyscaffoldSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblyscaffoldSeries::len(self : BioseqassemblyscaffoldSeries) -> Int { self.vals.length() }

pub fn BioseqassemblyscaffoldSeries::sum(self : BioseqassemblyscaffoldSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblyscaffoldSeries::mean(self : BioseqassemblyscaffoldSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblyscaffoldSeries::min(self : BioseqassemblyscaffoldSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblyscaffoldSeries::max(self : BioseqassemblyscaffoldSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblyscaffoldSeries::range(self : BioseqassemblyscaffoldSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblyscaffoldSeries::variance(self : BioseqassemblyscaffoldSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblyscaffoldSeries::std(self : BioseqassemblyscaffoldSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblyscaffoldSeries::median(self : BioseqassemblyscaffoldSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblyscaffoldSeries::scale(self : BioseqassemblyscaffoldSeries, f : Double) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::add(self : BioseqassemblyscaffoldSeries, other : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::sub(self : BioseqassemblyscaffoldSeries, other : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::normalize(self : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblyscaffoldSeries::cumsum(self : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::to_string(self : BioseqassemblyscaffoldSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyscaffoldMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_scaffold_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyscaffoldMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_scaffold_matrix_identity(n : Int) -> BioseqassemblyscaffoldMatrix {
  let m = bio_seq_assembly_scaffold_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblyscaffoldMatrix::get(self : BioseqassemblyscaffoldMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblyscaffoldMatrix::transpose(self : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  let result = bio_seq_assembly_scaffold_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblyscaffoldMatrix::add(self : BioseqassemblyscaffoldMatrix, other : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_scaffold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblyscaffoldMatrix::scale(self : BioseqassemblyscaffoldMatrix, s : Double) -> BioseqassemblyscaffoldMatrix {
  let result = bio_seq_assembly_scaffold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblyscaffoldMatrix::multiply(self : BioseqassemblyscaffoldMatrix, other : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  if self.cols != other.rows { return bio_seq_assembly_scaffold_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_scaffold_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblyscaffoldMatrix::trace(self : BioseqassemblyscaffoldMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblyscaffoldMatrix::det(self : BioseqassemblyscaffoldMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblyscaffoldMatrix::norm(self : BioseqassemblyscaffoldMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblyscaffoldMatrix::to_string(self : BioseqassemblyscaffoldMatrix) -> String {
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

pub(all) struct BioseqassemblyscaffoldVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_scaffold_make_vector(comps : Array[Double]) -> BioseqassemblyscaffoldVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_scaffold_vector_zero(dim : Int) -> BioseqassemblyscaffoldVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblyscaffoldVector::add(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyscaffoldVector::sub(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyscaffoldVector::scale(self : BioseqassemblyscaffoldVector, s : Double) -> BioseqassemblyscaffoldVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblyscaffoldVector::dot(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblyscaffoldVector::norm(self : BioseqassemblyscaffoldVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblyscaffoldVector::normalize(self : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyscaffoldVector::dist(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblyscaffoldVector::to_string(self : BioseqassemblyscaffoldVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_scaffold_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_scaffold_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_scaffold_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_scaffold_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_scaffold_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_scaffold_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_scaffold_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_scaffold_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_scaffold_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_scaffold_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_scaffold_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_scaffold_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_scaffold_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_scaffold_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_scaffold_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_scaffold_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_scaffold_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_scaffold_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_scaffold_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_scaffold_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_scaffold_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_scaffold_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_scaffold_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_scaffold_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_scaffold_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_scaffold_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_scaffold_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_scaffold_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_scaffold_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblyscaffoldFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_frame_make(size : Int) -> BioseqassemblyscaffoldFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_frame_len(s : BioseqassemblyscaffoldFrame) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_frame_get(s : BioseqassemblyscaffoldFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_frame_set(s : BioseqassemblyscaffoldFrame, i : Int, v : Double) -> BioseqassemblyscaffoldFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_frame_sum(s : BioseqassemblyscaffoldFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_frame_mean(s : BioseqassemblyscaffoldFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_frame_scale(s : BioseqassemblyscaffoldFrame, f : Double) -> BioseqassemblyscaffoldFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_frame_add(a : BioseqassemblyscaffoldFrame, b : BioseqassemblyscaffoldFrame) -> BioseqassemblyscaffoldFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_frame_copy(s : BioseqassemblyscaffoldFrame) -> BioseqassemblyscaffoldFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_frame_fill(s : BioseqassemblyscaffoldFrame, v : Double) -> BioseqassemblyscaffoldFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_frame_min(s : BioseqassemblyscaffoldFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_frame_max(s : BioseqassemblyscaffoldFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_frame_to_string(s : BioseqassemblyscaffoldFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_table_make(size : Int) -> BioseqassemblyscaffoldTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_table_len(s : BioseqassemblyscaffoldTable) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_table_get(s : BioseqassemblyscaffoldTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_table_set(s : BioseqassemblyscaffoldTable, i : Int, v : Double) -> BioseqassemblyscaffoldTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_table_sum(s : BioseqassemblyscaffoldTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_table_mean(s : BioseqassemblyscaffoldTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_table_scale(s : BioseqassemblyscaffoldTable, f : Double) -> BioseqassemblyscaffoldTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_table_add(a : BioseqassemblyscaffoldTable, b : BioseqassemblyscaffoldTable) -> BioseqassemblyscaffoldTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_table_copy(s : BioseqassemblyscaffoldTable) -> BioseqassemblyscaffoldTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_table_fill(s : BioseqassemblyscaffoldTable, v : Double) -> BioseqassemblyscaffoldTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_table_min(s : BioseqassemblyscaffoldTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_table_max(s : BioseqassemblyscaffoldTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_table_to_string(s : BioseqassemblyscaffoldTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_graphn_make(size : Int) -> BioseqassemblyscaffoldGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_graphn_len(s : BioseqassemblyscaffoldGraphN) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_graphn_get(s : BioseqassemblyscaffoldGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_graphn_set(s : BioseqassemblyscaffoldGraphN, i : Int, v : Double) -> BioseqassemblyscaffoldGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_graphn_sum(s : BioseqassemblyscaffoldGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_graphn_mean(s : BioseqassemblyscaffoldGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_graphn_scale(s : BioseqassemblyscaffoldGraphN, f : Double) -> BioseqassemblyscaffoldGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_graphn_add(a : BioseqassemblyscaffoldGraphN, b : BioseqassemblyscaffoldGraphN) -> BioseqassemblyscaffoldGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_graphn_copy(s : BioseqassemblyscaffoldGraphN) -> BioseqassemblyscaffoldGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_graphn_fill(s : BioseqassemblyscaffoldGraphN, v : Double) -> BioseqassemblyscaffoldGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_graphn_min(s : BioseqassemblyscaffoldGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_graphn_max(s : BioseqassemblyscaffoldGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_graphn_to_string(s : BioseqassemblyscaffoldGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_node_make(size : Int) -> BioseqassemblyscaffoldNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_node_len(s : BioseqassemblyscaffoldNode) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_node_get(s : BioseqassemblyscaffoldNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_node_set(s : BioseqassemblyscaffoldNode, i : Int, v : Double) -> BioseqassemblyscaffoldNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_node_sum(s : BioseqassemblyscaffoldNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_node_mean(s : BioseqassemblyscaffoldNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_node_scale(s : BioseqassemblyscaffoldNode, f : Double) -> BioseqassemblyscaffoldNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_node_add(a : BioseqassemblyscaffoldNode, b : BioseqassemblyscaffoldNode) -> BioseqassemblyscaffoldNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_node_copy(s : BioseqassemblyscaffoldNode) -> BioseqassemblyscaffoldNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_node_fill(s : BioseqassemblyscaffoldNode, v : Double) -> BioseqassemblyscaffoldNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_node_min(s : BioseqassemblyscaffoldNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_node_max(s : BioseqassemblyscaffoldNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_node_to_string(s : BioseqassemblyscaffoldNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_edge_make(size : Int) -> BioseqassemblyscaffoldEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_edge_len(s : BioseqassemblyscaffoldEdge) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_edge_get(s : BioseqassemblyscaffoldEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_edge_set(s : BioseqassemblyscaffoldEdge, i : Int, v : Double) -> BioseqassemblyscaffoldEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_edge_sum(s : BioseqassemblyscaffoldEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_edge_mean(s : BioseqassemblyscaffoldEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_edge_scale(s : BioseqassemblyscaffoldEdge, f : Double) -> BioseqassemblyscaffoldEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_edge_add(a : BioseqassemblyscaffoldEdge, b : BioseqassemblyscaffoldEdge) -> BioseqassemblyscaffoldEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_edge_copy(s : BioseqassemblyscaffoldEdge) -> BioseqassemblyscaffoldEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_edge_fill(s : BioseqassemblyscaffoldEdge, v : Double) -> BioseqassemblyscaffoldEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_edge_min(s : BioseqassemblyscaffoldEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_edge_max(s : BioseqassemblyscaffoldEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_edge_to_string(s : BioseqassemblyscaffoldEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_path_make(size : Int) -> BioseqassemblyscaffoldPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_path_len(s : BioseqassemblyscaffoldPath) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_path_get(s : BioseqassemblyscaffoldPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_path_set(s : BioseqassemblyscaffoldPath, i : Int, v : Double) -> BioseqassemblyscaffoldPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_path_sum(s : BioseqassemblyscaffoldPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_path_mean(s : BioseqassemblyscaffoldPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_path_scale(s : BioseqassemblyscaffoldPath, f : Double) -> BioseqassemblyscaffoldPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_path_add(a : BioseqassemblyscaffoldPath, b : BioseqassemblyscaffoldPath) -> BioseqassemblyscaffoldPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_path_copy(s : BioseqassemblyscaffoldPath) -> BioseqassemblyscaffoldPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_path_fill(s : BioseqassemblyscaffoldPath, v : Double) -> BioseqassemblyscaffoldPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_path_min(s : BioseqassemblyscaffoldPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_path_max(s : BioseqassemblyscaffoldPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_path_to_string(s : BioseqassemblyscaffoldPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_cluster_make(size : Int) -> BioseqassemblyscaffoldCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_cluster_len(s : BioseqassemblyscaffoldCluster) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_cluster_get(s : BioseqassemblyscaffoldCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_cluster_set(s : BioseqassemblyscaffoldCluster, i : Int, v : Double) -> BioseqassemblyscaffoldCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cluster_sum(s : BioseqassemblyscaffoldCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_cluster_mean(s : BioseqassemblyscaffoldCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_cluster_scale(s : BioseqassemblyscaffoldCluster, f : Double) -> BioseqassemblyscaffoldCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cluster_add(a : BioseqassemblyscaffoldCluster, b : BioseqassemblyscaffoldCluster) -> BioseqassemblyscaffoldCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_cluster_copy(s : BioseqassemblyscaffoldCluster) -> BioseqassemblyscaffoldCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cluster_fill(s : BioseqassemblyscaffoldCluster, v : Double) -> BioseqassemblyscaffoldCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cluster_min(s : BioseqassemblyscaffoldCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_cluster_max(s : BioseqassemblyscaffoldCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_cluster_to_string(s : BioseqassemblyscaffoldCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_model_make(size : Int) -> BioseqassemblyscaffoldModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_model_len(s : BioseqassemblyscaffoldModel) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_model_get(s : BioseqassemblyscaffoldModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_model_set(s : BioseqassemblyscaffoldModel, i : Int, v : Double) -> BioseqassemblyscaffoldModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_model_sum(s : BioseqassemblyscaffoldModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_model_mean(s : BioseqassemblyscaffoldModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_model_scale(s : BioseqassemblyscaffoldModel, f : Double) -> BioseqassemblyscaffoldModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_model_add(a : BioseqassemblyscaffoldModel, b : BioseqassemblyscaffoldModel) -> BioseqassemblyscaffoldModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_model_copy(s : BioseqassemblyscaffoldModel) -> BioseqassemblyscaffoldModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_model_fill(s : BioseqassemblyscaffoldModel, v : Double) -> BioseqassemblyscaffoldModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_model_min(s : BioseqassemblyscaffoldModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_model_max(s : BioseqassemblyscaffoldModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_model_to_string(s : BioseqassemblyscaffoldModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_layer_make(size : Int) -> BioseqassemblyscaffoldLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_layer_len(s : BioseqassemblyscaffoldLayer) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_layer_get(s : BioseqassemblyscaffoldLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_layer_set(s : BioseqassemblyscaffoldLayer, i : Int, v : Double) -> BioseqassemblyscaffoldLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_layer_sum(s : BioseqassemblyscaffoldLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_layer_mean(s : BioseqassemblyscaffoldLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_layer_scale(s : BioseqassemblyscaffoldLayer, f : Double) -> BioseqassemblyscaffoldLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_layer_add(a : BioseqassemblyscaffoldLayer, b : BioseqassemblyscaffoldLayer) -> BioseqassemblyscaffoldLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_layer_copy(s : BioseqassemblyscaffoldLayer) -> BioseqassemblyscaffoldLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_layer_fill(s : BioseqassemblyscaffoldLayer, v : Double) -> BioseqassemblyscaffoldLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_layer_min(s : BioseqassemblyscaffoldLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_layer_max(s : BioseqassemblyscaffoldLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_layer_to_string(s : BioseqassemblyscaffoldLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_buffer_make(size : Int) -> BioseqassemblyscaffoldBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_buffer_len(s : BioseqassemblyscaffoldBuffer) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_buffer_get(s : BioseqassemblyscaffoldBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_buffer_set(s : BioseqassemblyscaffoldBuffer, i : Int, v : Double) -> BioseqassemblyscaffoldBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_buffer_sum(s : BioseqassemblyscaffoldBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_buffer_mean(s : BioseqassemblyscaffoldBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_buffer_scale(s : BioseqassemblyscaffoldBuffer, f : Double) -> BioseqassemblyscaffoldBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_buffer_add(a : BioseqassemblyscaffoldBuffer, b : BioseqassemblyscaffoldBuffer) -> BioseqassemblyscaffoldBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_buffer_copy(s : BioseqassemblyscaffoldBuffer) -> BioseqassemblyscaffoldBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_buffer_fill(s : BioseqassemblyscaffoldBuffer, v : Double) -> BioseqassemblyscaffoldBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_buffer_min(s : BioseqassemblyscaffoldBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_buffer_max(s : BioseqassemblyscaffoldBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_buffer_to_string(s : BioseqassemblyscaffoldBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_cursor_make(size : Int) -> BioseqassemblyscaffoldCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_cursor_len(s : BioseqassemblyscaffoldCursor) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_cursor_get(s : BioseqassemblyscaffoldCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_cursor_set(s : BioseqassemblyscaffoldCursor, i : Int, v : Double) -> BioseqassemblyscaffoldCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cursor_sum(s : BioseqassemblyscaffoldCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_cursor_mean(s : BioseqassemblyscaffoldCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_cursor_scale(s : BioseqassemblyscaffoldCursor, f : Double) -> BioseqassemblyscaffoldCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cursor_add(a : BioseqassemblyscaffoldCursor, b : BioseqassemblyscaffoldCursor) -> BioseqassemblyscaffoldCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_cursor_copy(s : BioseqassemblyscaffoldCursor) -> BioseqassemblyscaffoldCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cursor_fill(s : BioseqassemblyscaffoldCursor, v : Double) -> BioseqassemblyscaffoldCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_cursor_min(s : BioseqassemblyscaffoldCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_cursor_max(s : BioseqassemblyscaffoldCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_cursor_to_string(s : BioseqassemblyscaffoldCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_view_make(size : Int) -> BioseqassemblyscaffoldView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_view_len(s : BioseqassemblyscaffoldView) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_view_get(s : BioseqassemblyscaffoldView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_view_set(s : BioseqassemblyscaffoldView, i : Int, v : Double) -> BioseqassemblyscaffoldView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_view_sum(s : BioseqassemblyscaffoldView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_view_mean(s : BioseqassemblyscaffoldView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_view_scale(s : BioseqassemblyscaffoldView, f : Double) -> BioseqassemblyscaffoldView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_view_add(a : BioseqassemblyscaffoldView, b : BioseqassemblyscaffoldView) -> BioseqassemblyscaffoldView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_view_copy(s : BioseqassemblyscaffoldView) -> BioseqassemblyscaffoldView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_view_fill(s : BioseqassemblyscaffoldView, v : Double) -> BioseqassemblyscaffoldView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_view_min(s : BioseqassemblyscaffoldView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_view_max(s : BioseqassemblyscaffoldView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_view_to_string(s : BioseqassemblyscaffoldView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_range_make(size : Int) -> BioseqassemblyscaffoldRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_range_len(s : BioseqassemblyscaffoldRange) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_range_get(s : BioseqassemblyscaffoldRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_range_set(s : BioseqassemblyscaffoldRange, i : Int, v : Double) -> BioseqassemblyscaffoldRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_range_sum(s : BioseqassemblyscaffoldRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_range_mean(s : BioseqassemblyscaffoldRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_range_scale(s : BioseqassemblyscaffoldRange, f : Double) -> BioseqassemblyscaffoldRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_range_add(a : BioseqassemblyscaffoldRange, b : BioseqassemblyscaffoldRange) -> BioseqassemblyscaffoldRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_range_copy(s : BioseqassemblyscaffoldRange) -> BioseqassemblyscaffoldRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_range_fill(s : BioseqassemblyscaffoldRange, v : Double) -> BioseqassemblyscaffoldRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_range_min(s : BioseqassemblyscaffoldRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_range_max(s : BioseqassemblyscaffoldRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_range_to_string(s : BioseqassemblyscaffoldRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_slice_make(size : Int) -> BioseqassemblyscaffoldSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_slice_len(s : BioseqassemblyscaffoldSlice) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_slice_get(s : BioseqassemblyscaffoldSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_slice_set(s : BioseqassemblyscaffoldSlice, i : Int, v : Double) -> BioseqassemblyscaffoldSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_slice_sum(s : BioseqassemblyscaffoldSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_scaffold_slice_mean(s : BioseqassemblyscaffoldSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_scaffold_slice_scale(s : BioseqassemblyscaffoldSlice, f : Double) -> BioseqassemblyscaffoldSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_slice_add(a : BioseqassemblyscaffoldSlice, b : BioseqassemblyscaffoldSlice) -> BioseqassemblyscaffoldSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_scaffold_slice_copy(s : BioseqassemblyscaffoldSlice) -> BioseqassemblyscaffoldSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_slice_fill(s : BioseqassemblyscaffoldSlice, v : Double) -> BioseqassemblyscaffoldSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_scaffold_slice_min(s : BioseqassemblyscaffoldSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_scaffold_slice_max(s : BioseqassemblyscaffoldSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_scaffold_slice_to_string(s : BioseqassemblyscaffoldSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

