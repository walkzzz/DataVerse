///===
/// extcore/bio_seq_align_profile

pub(all) struct BioseqalignprofilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_profile_make_point(x : Double, y : Double) -> BioseqalignprofilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_profile_make_point3(x : Double, y : Double, z : Double) -> BioseqalignprofilePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignprofilePoint::x(self : BioseqalignprofilePoint) -> Double { self.x }

pub fn BioseqalignprofilePoint::y(self : BioseqalignprofilePoint) -> Double { self.y }

pub fn BioseqalignprofilePoint::z(self : BioseqalignprofilePoint) -> Double { self.z }

pub fn BioseqalignprofilePoint::label(self : BioseqalignprofilePoint) -> Int { self.label }

pub fn BioseqalignprofilePoint::dist(self : BioseqalignprofilePoint, other : BioseqalignprofilePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignprofilePoint::add(self : BioseqalignprofilePoint, other : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignprofilePoint::sub(self : BioseqalignprofilePoint, other : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignprofilePoint::scale(self : BioseqalignprofilePoint, s : Double) -> BioseqalignprofilePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignprofilePoint::dot(self : BioseqalignprofilePoint, other : BioseqalignprofilePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignprofilePoint::cross(self : BioseqalignprofilePoint, other : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignprofilePoint::norm(self : BioseqalignprofilePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignprofilePoint::normalize(self : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignprofilePoint::negate(self : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignprofilePoint::mid(self : BioseqalignprofilePoint, other : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignprofilePoint::lerp(self : BioseqalignprofilePoint, other : BioseqalignprofilePoint, t : Double) -> BioseqalignprofilePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignprofilePoint::to_string(self : BioseqalignprofilePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignprofileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_profile_make_series(vals : Array[Double], name : String) -> BioseqalignprofileSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignprofileSeries::len(self : BioseqalignprofileSeries) -> Int { self.vals.length() }

pub fn BioseqalignprofileSeries::sum(self : BioseqalignprofileSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignprofileSeries::mean(self : BioseqalignprofileSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignprofileSeries::min(self : BioseqalignprofileSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignprofileSeries::max(self : BioseqalignprofileSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignprofileSeries::range(self : BioseqalignprofileSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignprofileSeries::variance(self : BioseqalignprofileSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignprofileSeries::std(self : BioseqalignprofileSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignprofileSeries::median(self : BioseqalignprofileSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignprofileSeries::scale(self : BioseqalignprofileSeries, f : Double) -> BioseqalignprofileSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignprofileSeries::add(self : BioseqalignprofileSeries, other : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignprofileSeries::sub(self : BioseqalignprofileSeries, other : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignprofileSeries::normalize(self : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignprofileSeries::cumsum(self : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignprofileSeries::to_string(self : BioseqalignprofileSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignprofileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_profile_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignprofileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_profile_matrix_identity(n : Int) -> BioseqalignprofileMatrix {
  let m = bio_seq_align_profile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignprofileMatrix::get(self : BioseqalignprofileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignprofileMatrix::transpose(self : BioseqalignprofileMatrix) -> BioseqalignprofileMatrix {
  let result = bio_seq_align_profile_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignprofileMatrix::add(self : BioseqalignprofileMatrix, other : BioseqalignprofileMatrix) -> BioseqalignprofileMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_profile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignprofileMatrix::scale(self : BioseqalignprofileMatrix, s : Double) -> BioseqalignprofileMatrix {
  let result = bio_seq_align_profile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignprofileMatrix::multiply(self : BioseqalignprofileMatrix, other : BioseqalignprofileMatrix) -> BioseqalignprofileMatrix {
  if self.cols != other.rows { return bio_seq_align_profile_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_profile_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqalignprofileMatrix::trace(self : BioseqalignprofileMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignprofileMatrix::det(self : BioseqalignprofileMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignprofileMatrix::norm(self : BioseqalignprofileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignprofileMatrix::to_string(self : BioseqalignprofileMatrix) -> String {
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

pub(all) struct BioseqalignprofileVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_profile_make_vector(comps : Array[Double]) -> BioseqalignprofileVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_profile_vector_zero(dim : Int) -> BioseqalignprofileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignprofileVector::add(self : BioseqalignprofileVector, other : BioseqalignprofileVector) -> BioseqalignprofileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignprofileVector::sub(self : BioseqalignprofileVector, other : BioseqalignprofileVector) -> BioseqalignprofileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignprofileVector::scale(self : BioseqalignprofileVector, s : Double) -> BioseqalignprofileVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignprofileVector::dot(self : BioseqalignprofileVector, other : BioseqalignprofileVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignprofileVector::norm(self : BioseqalignprofileVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignprofileVector::normalize(self : BioseqalignprofileVector) -> BioseqalignprofileVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignprofileVector::dist(self : BioseqalignprofileVector, other : BioseqalignprofileVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignprofileVector::to_string(self : BioseqalignprofileVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_profile_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_profile_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_profile_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_profile_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_profile_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_profile_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_profile_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_profile_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_profile_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_profile_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_profile_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_profile_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_profile_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_profile_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_profile_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_profile_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_profile_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_profile_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_profile_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_profile_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_profile_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_profile_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_profile_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_profile_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_profile_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_profile_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_profile_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_profile_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_profile_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignprofileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_frame_make(size : Int) -> BioseqalignprofileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_frame_len(s : BioseqalignprofileFrame) -> Int { s.size }

pub fn bio_seq_align_profile_frame_get(s : BioseqalignprofileFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_frame_set(s : BioseqalignprofileFrame, i : Int, v : Double) -> BioseqalignprofileFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_frame_sum(s : BioseqalignprofileFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_frame_mean(s : BioseqalignprofileFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_frame_scale(s : BioseqalignprofileFrame, f : Double) -> BioseqalignprofileFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_frame_add(a : BioseqalignprofileFrame, b : BioseqalignprofileFrame) -> BioseqalignprofileFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_frame_copy(s : BioseqalignprofileFrame) -> BioseqalignprofileFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_frame_fill(s : BioseqalignprofileFrame, v : Double) -> BioseqalignprofileFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_frame_min(s : BioseqalignprofileFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_frame_max(s : BioseqalignprofileFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_frame_to_string(s : BioseqalignprofileFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_table_make(size : Int) -> BioseqalignprofileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_table_len(s : BioseqalignprofileTable) -> Int { s.size }

pub fn bio_seq_align_profile_table_get(s : BioseqalignprofileTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_table_set(s : BioseqalignprofileTable, i : Int, v : Double) -> BioseqalignprofileTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_table_sum(s : BioseqalignprofileTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_table_mean(s : BioseqalignprofileTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_table_scale(s : BioseqalignprofileTable, f : Double) -> BioseqalignprofileTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_table_add(a : BioseqalignprofileTable, b : BioseqalignprofileTable) -> BioseqalignprofileTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_table_copy(s : BioseqalignprofileTable) -> BioseqalignprofileTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_table_fill(s : BioseqalignprofileTable, v : Double) -> BioseqalignprofileTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_table_min(s : BioseqalignprofileTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_table_max(s : BioseqalignprofileTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_table_to_string(s : BioseqalignprofileTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_graphn_make(size : Int) -> BioseqalignprofileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_graphn_len(s : BioseqalignprofileGraphN) -> Int { s.size }

pub fn bio_seq_align_profile_graphn_get(s : BioseqalignprofileGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_graphn_set(s : BioseqalignprofileGraphN, i : Int, v : Double) -> BioseqalignprofileGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_graphn_sum(s : BioseqalignprofileGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_graphn_mean(s : BioseqalignprofileGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_graphn_scale(s : BioseqalignprofileGraphN, f : Double) -> BioseqalignprofileGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_graphn_add(a : BioseqalignprofileGraphN, b : BioseqalignprofileGraphN) -> BioseqalignprofileGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_graphn_copy(s : BioseqalignprofileGraphN) -> BioseqalignprofileGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_graphn_fill(s : BioseqalignprofileGraphN, v : Double) -> BioseqalignprofileGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_graphn_min(s : BioseqalignprofileGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_graphn_max(s : BioseqalignprofileGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_graphn_to_string(s : BioseqalignprofileGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_node_make(size : Int) -> BioseqalignprofileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_node_len(s : BioseqalignprofileNode) -> Int { s.size }

pub fn bio_seq_align_profile_node_get(s : BioseqalignprofileNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_node_set(s : BioseqalignprofileNode, i : Int, v : Double) -> BioseqalignprofileNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_node_sum(s : BioseqalignprofileNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_node_mean(s : BioseqalignprofileNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_node_scale(s : BioseqalignprofileNode, f : Double) -> BioseqalignprofileNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_node_add(a : BioseqalignprofileNode, b : BioseqalignprofileNode) -> BioseqalignprofileNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_node_copy(s : BioseqalignprofileNode) -> BioseqalignprofileNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_node_fill(s : BioseqalignprofileNode, v : Double) -> BioseqalignprofileNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_node_min(s : BioseqalignprofileNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_node_max(s : BioseqalignprofileNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_node_to_string(s : BioseqalignprofileNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_edge_make(size : Int) -> BioseqalignprofileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_edge_len(s : BioseqalignprofileEdge) -> Int { s.size }

pub fn bio_seq_align_profile_edge_get(s : BioseqalignprofileEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_edge_set(s : BioseqalignprofileEdge, i : Int, v : Double) -> BioseqalignprofileEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_edge_sum(s : BioseqalignprofileEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_edge_mean(s : BioseqalignprofileEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_edge_scale(s : BioseqalignprofileEdge, f : Double) -> BioseqalignprofileEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_edge_add(a : BioseqalignprofileEdge, b : BioseqalignprofileEdge) -> BioseqalignprofileEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_edge_copy(s : BioseqalignprofileEdge) -> BioseqalignprofileEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_edge_fill(s : BioseqalignprofileEdge, v : Double) -> BioseqalignprofileEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_edge_min(s : BioseqalignprofileEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_edge_max(s : BioseqalignprofileEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_edge_to_string(s : BioseqalignprofileEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_path_make(size : Int) -> BioseqalignprofilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_path_len(s : BioseqalignprofilePath) -> Int { s.size }

pub fn bio_seq_align_profile_path_get(s : BioseqalignprofilePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_path_set(s : BioseqalignprofilePath, i : Int, v : Double) -> BioseqalignprofilePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_path_sum(s : BioseqalignprofilePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_path_mean(s : BioseqalignprofilePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_path_scale(s : BioseqalignprofilePath, f : Double) -> BioseqalignprofilePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_path_add(a : BioseqalignprofilePath, b : BioseqalignprofilePath) -> BioseqalignprofilePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_path_copy(s : BioseqalignprofilePath) -> BioseqalignprofilePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_path_fill(s : BioseqalignprofilePath, v : Double) -> BioseqalignprofilePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_path_min(s : BioseqalignprofilePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_path_max(s : BioseqalignprofilePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_path_to_string(s : BioseqalignprofilePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_cluster_make(size : Int) -> BioseqalignprofileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_cluster_len(s : BioseqalignprofileCluster) -> Int { s.size }

pub fn bio_seq_align_profile_cluster_get(s : BioseqalignprofileCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_cluster_set(s : BioseqalignprofileCluster, i : Int, v : Double) -> BioseqalignprofileCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cluster_sum(s : BioseqalignprofileCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_cluster_mean(s : BioseqalignprofileCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_cluster_scale(s : BioseqalignprofileCluster, f : Double) -> BioseqalignprofileCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cluster_add(a : BioseqalignprofileCluster, b : BioseqalignprofileCluster) -> BioseqalignprofileCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_cluster_copy(s : BioseqalignprofileCluster) -> BioseqalignprofileCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cluster_fill(s : BioseqalignprofileCluster, v : Double) -> BioseqalignprofileCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cluster_min(s : BioseqalignprofileCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_cluster_max(s : BioseqalignprofileCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_cluster_to_string(s : BioseqalignprofileCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_model_make(size : Int) -> BioseqalignprofileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_model_len(s : BioseqalignprofileModel) -> Int { s.size }

pub fn bio_seq_align_profile_model_get(s : BioseqalignprofileModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_model_set(s : BioseqalignprofileModel, i : Int, v : Double) -> BioseqalignprofileModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_model_sum(s : BioseqalignprofileModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_model_mean(s : BioseqalignprofileModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_model_scale(s : BioseqalignprofileModel, f : Double) -> BioseqalignprofileModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_model_add(a : BioseqalignprofileModel, b : BioseqalignprofileModel) -> BioseqalignprofileModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_model_copy(s : BioseqalignprofileModel) -> BioseqalignprofileModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_model_fill(s : BioseqalignprofileModel, v : Double) -> BioseqalignprofileModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_model_min(s : BioseqalignprofileModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_model_max(s : BioseqalignprofileModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_model_to_string(s : BioseqalignprofileModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_layer_make(size : Int) -> BioseqalignprofileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_layer_len(s : BioseqalignprofileLayer) -> Int { s.size }

pub fn bio_seq_align_profile_layer_get(s : BioseqalignprofileLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_layer_set(s : BioseqalignprofileLayer, i : Int, v : Double) -> BioseqalignprofileLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_layer_sum(s : BioseqalignprofileLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_layer_mean(s : BioseqalignprofileLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_layer_scale(s : BioseqalignprofileLayer, f : Double) -> BioseqalignprofileLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_layer_add(a : BioseqalignprofileLayer, b : BioseqalignprofileLayer) -> BioseqalignprofileLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_layer_copy(s : BioseqalignprofileLayer) -> BioseqalignprofileLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_layer_fill(s : BioseqalignprofileLayer, v : Double) -> BioseqalignprofileLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_layer_min(s : BioseqalignprofileLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_layer_max(s : BioseqalignprofileLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_layer_to_string(s : BioseqalignprofileLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_buffer_make(size : Int) -> BioseqalignprofileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_buffer_len(s : BioseqalignprofileBuffer) -> Int { s.size }

pub fn bio_seq_align_profile_buffer_get(s : BioseqalignprofileBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_buffer_set(s : BioseqalignprofileBuffer, i : Int, v : Double) -> BioseqalignprofileBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_buffer_sum(s : BioseqalignprofileBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_buffer_mean(s : BioseqalignprofileBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_buffer_scale(s : BioseqalignprofileBuffer, f : Double) -> BioseqalignprofileBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_buffer_add(a : BioseqalignprofileBuffer, b : BioseqalignprofileBuffer) -> BioseqalignprofileBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_buffer_copy(s : BioseqalignprofileBuffer) -> BioseqalignprofileBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_buffer_fill(s : BioseqalignprofileBuffer, v : Double) -> BioseqalignprofileBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_buffer_min(s : BioseqalignprofileBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_buffer_max(s : BioseqalignprofileBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_buffer_to_string(s : BioseqalignprofileBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_cursor_make(size : Int) -> BioseqalignprofileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_cursor_len(s : BioseqalignprofileCursor) -> Int { s.size }

pub fn bio_seq_align_profile_cursor_get(s : BioseqalignprofileCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_cursor_set(s : BioseqalignprofileCursor, i : Int, v : Double) -> BioseqalignprofileCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cursor_sum(s : BioseqalignprofileCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_cursor_mean(s : BioseqalignprofileCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_cursor_scale(s : BioseqalignprofileCursor, f : Double) -> BioseqalignprofileCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cursor_add(a : BioseqalignprofileCursor, b : BioseqalignprofileCursor) -> BioseqalignprofileCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_cursor_copy(s : BioseqalignprofileCursor) -> BioseqalignprofileCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cursor_fill(s : BioseqalignprofileCursor, v : Double) -> BioseqalignprofileCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_cursor_min(s : BioseqalignprofileCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_cursor_max(s : BioseqalignprofileCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_cursor_to_string(s : BioseqalignprofileCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_view_make(size : Int) -> BioseqalignprofileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_view_len(s : BioseqalignprofileView) -> Int { s.size }

pub fn bio_seq_align_profile_view_get(s : BioseqalignprofileView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_view_set(s : BioseqalignprofileView, i : Int, v : Double) -> BioseqalignprofileView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_view_sum(s : BioseqalignprofileView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_view_mean(s : BioseqalignprofileView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_view_scale(s : BioseqalignprofileView, f : Double) -> BioseqalignprofileView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_view_add(a : BioseqalignprofileView, b : BioseqalignprofileView) -> BioseqalignprofileView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_view_copy(s : BioseqalignprofileView) -> BioseqalignprofileView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_view_fill(s : BioseqalignprofileView, v : Double) -> BioseqalignprofileView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_view_min(s : BioseqalignprofileView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_view_max(s : BioseqalignprofileView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_view_to_string(s : BioseqalignprofileView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_range_make(size : Int) -> BioseqalignprofileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_range_len(s : BioseqalignprofileRange) -> Int { s.size }

pub fn bio_seq_align_profile_range_get(s : BioseqalignprofileRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_range_set(s : BioseqalignprofileRange, i : Int, v : Double) -> BioseqalignprofileRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_range_sum(s : BioseqalignprofileRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_range_mean(s : BioseqalignprofileRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_range_scale(s : BioseqalignprofileRange, f : Double) -> BioseqalignprofileRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_range_add(a : BioseqalignprofileRange, b : BioseqalignprofileRange) -> BioseqalignprofileRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_range_copy(s : BioseqalignprofileRange) -> BioseqalignprofileRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_range_fill(s : BioseqalignprofileRange, v : Double) -> BioseqalignprofileRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_range_min(s : BioseqalignprofileRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_range_max(s : BioseqalignprofileRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_range_to_string(s : BioseqalignprofileRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_slice_make(size : Int) -> BioseqalignprofileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_slice_len(s : BioseqalignprofileSlice) -> Int { s.size }

pub fn bio_seq_align_profile_slice_get(s : BioseqalignprofileSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_slice_set(s : BioseqalignprofileSlice, i : Int, v : Double) -> BioseqalignprofileSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_slice_sum(s : BioseqalignprofileSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_profile_slice_mean(s : BioseqalignprofileSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_profile_slice_scale(s : BioseqalignprofileSlice, f : Double) -> BioseqalignprofileSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_slice_add(a : BioseqalignprofileSlice, b : BioseqalignprofileSlice) -> BioseqalignprofileSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_profile_slice_copy(s : BioseqalignprofileSlice) -> BioseqalignprofileSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_slice_fill(s : BioseqalignprofileSlice, v : Double) -> BioseqalignprofileSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_profile_slice_min(s : BioseqalignprofileSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_profile_slice_max(s : BioseqalignprofileSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_profile_slice_to_string(s : BioseqalignprofileSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

