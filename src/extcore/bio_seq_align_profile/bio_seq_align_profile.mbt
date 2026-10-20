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

pub fn BioseqalignprofileFrame::len(self : BioseqalignprofileFrame) -> Int { self.size }

pub fn BioseqalignprofileFrame::get(self : BioseqalignprofileFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileFrame::set(self : BioseqalignprofileFrame, i : Int, v : Double) -> BioseqalignprofileFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileFrame::sum(self : BioseqalignprofileFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileFrame::mean(self : BioseqalignprofileFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileFrame::scale(self : BioseqalignprofileFrame, f : Double) -> BioseqalignprofileFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileFrame::add(self : BioseqalignprofileFrame, other : BioseqalignprofileFrame) -> BioseqalignprofileFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileFrame::copy(self : BioseqalignprofileFrame) -> BioseqalignprofileFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileFrame::fill(self : BioseqalignprofileFrame, v : Double) -> BioseqalignprofileFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileFrame::min(self : BioseqalignprofileFrame) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileFrame::max(self : BioseqalignprofileFrame) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileFrame::to_string(self : BioseqalignprofileFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_table_make(size : Int) -> BioseqalignprofileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileTable::len(self : BioseqalignprofileTable) -> Int { self.size }

pub fn BioseqalignprofileTable::get(self : BioseqalignprofileTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileTable::set(self : BioseqalignprofileTable, i : Int, v : Double) -> BioseqalignprofileTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileTable::sum(self : BioseqalignprofileTable) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileTable::mean(self : BioseqalignprofileTable) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileTable::scale(self : BioseqalignprofileTable, f : Double) -> BioseqalignprofileTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileTable::add(self : BioseqalignprofileTable, other : BioseqalignprofileTable) -> BioseqalignprofileTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileTable::copy(self : BioseqalignprofileTable) -> BioseqalignprofileTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileTable::fill(self : BioseqalignprofileTable, v : Double) -> BioseqalignprofileTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileTable::min(self : BioseqalignprofileTable) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileTable::max(self : BioseqalignprofileTable) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileTable::to_string(self : BioseqalignprofileTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_graphn_make(size : Int) -> BioseqalignprofileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileGraphN::len(self : BioseqalignprofileGraphN) -> Int { self.size }

pub fn BioseqalignprofileGraphN::get(self : BioseqalignprofileGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileGraphN::set(self : BioseqalignprofileGraphN, i : Int, v : Double) -> BioseqalignprofileGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileGraphN::sum(self : BioseqalignprofileGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileGraphN::mean(self : BioseqalignprofileGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileGraphN::scale(self : BioseqalignprofileGraphN, f : Double) -> BioseqalignprofileGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileGraphN::add(self : BioseqalignprofileGraphN, other : BioseqalignprofileGraphN) -> BioseqalignprofileGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileGraphN::copy(self : BioseqalignprofileGraphN) -> BioseqalignprofileGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileGraphN::fill(self : BioseqalignprofileGraphN, v : Double) -> BioseqalignprofileGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileGraphN::min(self : BioseqalignprofileGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileGraphN::max(self : BioseqalignprofileGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileGraphN::to_string(self : BioseqalignprofileGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_node_make(size : Int) -> BioseqalignprofileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileNode::len(self : BioseqalignprofileNode) -> Int { self.size }

pub fn BioseqalignprofileNode::get(self : BioseqalignprofileNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileNode::set(self : BioseqalignprofileNode, i : Int, v : Double) -> BioseqalignprofileNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileNode::sum(self : BioseqalignprofileNode) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileNode::mean(self : BioseqalignprofileNode) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileNode::scale(self : BioseqalignprofileNode, f : Double) -> BioseqalignprofileNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileNode::add(self : BioseqalignprofileNode, other : BioseqalignprofileNode) -> BioseqalignprofileNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileNode::copy(self : BioseqalignprofileNode) -> BioseqalignprofileNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileNode::fill(self : BioseqalignprofileNode, v : Double) -> BioseqalignprofileNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileNode::min(self : BioseqalignprofileNode) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileNode::max(self : BioseqalignprofileNode) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileNode::to_string(self : BioseqalignprofileNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_edge_make(size : Int) -> BioseqalignprofileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileEdge::len(self : BioseqalignprofileEdge) -> Int { self.size }

pub fn BioseqalignprofileEdge::get(self : BioseqalignprofileEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileEdge::set(self : BioseqalignprofileEdge, i : Int, v : Double) -> BioseqalignprofileEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileEdge::sum(self : BioseqalignprofileEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileEdge::mean(self : BioseqalignprofileEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileEdge::scale(self : BioseqalignprofileEdge, f : Double) -> BioseqalignprofileEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileEdge::add(self : BioseqalignprofileEdge, other : BioseqalignprofileEdge) -> BioseqalignprofileEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileEdge::copy(self : BioseqalignprofileEdge) -> BioseqalignprofileEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileEdge::fill(self : BioseqalignprofileEdge, v : Double) -> BioseqalignprofileEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileEdge::min(self : BioseqalignprofileEdge) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileEdge::max(self : BioseqalignprofileEdge) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileEdge::to_string(self : BioseqalignprofileEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_path_make(size : Int) -> BioseqalignprofilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofilePath::len(self : BioseqalignprofilePath) -> Int { self.size }

pub fn BioseqalignprofilePath::get(self : BioseqalignprofilePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofilePath::set(self : BioseqalignprofilePath, i : Int, v : Double) -> BioseqalignprofilePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofilePath::sum(self : BioseqalignprofilePath) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofilePath::mean(self : BioseqalignprofilePath) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofilePath::scale(self : BioseqalignprofilePath, f : Double) -> BioseqalignprofilePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofilePath::add(self : BioseqalignprofilePath, other : BioseqalignprofilePath) -> BioseqalignprofilePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofilePath::copy(self : BioseqalignprofilePath) -> BioseqalignprofilePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofilePath::fill(self : BioseqalignprofilePath, v : Double) -> BioseqalignprofilePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofilePath::min(self : BioseqalignprofilePath) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofilePath::max(self : BioseqalignprofilePath) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofilePath::to_string(self : BioseqalignprofilePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_cluster_make(size : Int) -> BioseqalignprofileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileCluster::len(self : BioseqalignprofileCluster) -> Int { self.size }

pub fn BioseqalignprofileCluster::get(self : BioseqalignprofileCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileCluster::set(self : BioseqalignprofileCluster, i : Int, v : Double) -> BioseqalignprofileCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCluster::sum(self : BioseqalignprofileCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileCluster::mean(self : BioseqalignprofileCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileCluster::scale(self : BioseqalignprofileCluster, f : Double) -> BioseqalignprofileCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCluster::add(self : BioseqalignprofileCluster, other : BioseqalignprofileCluster) -> BioseqalignprofileCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileCluster::copy(self : BioseqalignprofileCluster) -> BioseqalignprofileCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCluster::fill(self : BioseqalignprofileCluster, v : Double) -> BioseqalignprofileCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCluster::min(self : BioseqalignprofileCluster) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileCluster::max(self : BioseqalignprofileCluster) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileCluster::to_string(self : BioseqalignprofileCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_model_make(size : Int) -> BioseqalignprofileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileModel::len(self : BioseqalignprofileModel) -> Int { self.size }

pub fn BioseqalignprofileModel::get(self : BioseqalignprofileModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileModel::set(self : BioseqalignprofileModel, i : Int, v : Double) -> BioseqalignprofileModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileModel::sum(self : BioseqalignprofileModel) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileModel::mean(self : BioseqalignprofileModel) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileModel::scale(self : BioseqalignprofileModel, f : Double) -> BioseqalignprofileModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileModel::add(self : BioseqalignprofileModel, other : BioseqalignprofileModel) -> BioseqalignprofileModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileModel::copy(self : BioseqalignprofileModel) -> BioseqalignprofileModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileModel::fill(self : BioseqalignprofileModel, v : Double) -> BioseqalignprofileModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileModel::min(self : BioseqalignprofileModel) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileModel::max(self : BioseqalignprofileModel) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileModel::to_string(self : BioseqalignprofileModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_layer_make(size : Int) -> BioseqalignprofileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileLayer::len(self : BioseqalignprofileLayer) -> Int { self.size }

pub fn BioseqalignprofileLayer::get(self : BioseqalignprofileLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileLayer::set(self : BioseqalignprofileLayer, i : Int, v : Double) -> BioseqalignprofileLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileLayer::sum(self : BioseqalignprofileLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileLayer::mean(self : BioseqalignprofileLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileLayer::scale(self : BioseqalignprofileLayer, f : Double) -> BioseqalignprofileLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileLayer::add(self : BioseqalignprofileLayer, other : BioseqalignprofileLayer) -> BioseqalignprofileLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileLayer::copy(self : BioseqalignprofileLayer) -> BioseqalignprofileLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileLayer::fill(self : BioseqalignprofileLayer, v : Double) -> BioseqalignprofileLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileLayer::min(self : BioseqalignprofileLayer) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileLayer::max(self : BioseqalignprofileLayer) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileLayer::to_string(self : BioseqalignprofileLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_buffer_make(size : Int) -> BioseqalignprofileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileBuffer::len(self : BioseqalignprofileBuffer) -> Int { self.size }

pub fn BioseqalignprofileBuffer::get(self : BioseqalignprofileBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileBuffer::set(self : BioseqalignprofileBuffer, i : Int, v : Double) -> BioseqalignprofileBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileBuffer::sum(self : BioseqalignprofileBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileBuffer::mean(self : BioseqalignprofileBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileBuffer::scale(self : BioseqalignprofileBuffer, f : Double) -> BioseqalignprofileBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileBuffer::add(self : BioseqalignprofileBuffer, other : BioseqalignprofileBuffer) -> BioseqalignprofileBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileBuffer::copy(self : BioseqalignprofileBuffer) -> BioseqalignprofileBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileBuffer::fill(self : BioseqalignprofileBuffer, v : Double) -> BioseqalignprofileBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileBuffer::min(self : BioseqalignprofileBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileBuffer::max(self : BioseqalignprofileBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileBuffer::to_string(self : BioseqalignprofileBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_cursor_make(size : Int) -> BioseqalignprofileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileCursor::len(self : BioseqalignprofileCursor) -> Int { self.size }

pub fn BioseqalignprofileCursor::get(self : BioseqalignprofileCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileCursor::set(self : BioseqalignprofileCursor, i : Int, v : Double) -> BioseqalignprofileCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCursor::sum(self : BioseqalignprofileCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileCursor::mean(self : BioseqalignprofileCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileCursor::scale(self : BioseqalignprofileCursor, f : Double) -> BioseqalignprofileCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCursor::add(self : BioseqalignprofileCursor, other : BioseqalignprofileCursor) -> BioseqalignprofileCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileCursor::copy(self : BioseqalignprofileCursor) -> BioseqalignprofileCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCursor::fill(self : BioseqalignprofileCursor, v : Double) -> BioseqalignprofileCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileCursor::min(self : BioseqalignprofileCursor) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileCursor::max(self : BioseqalignprofileCursor) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileCursor::to_string(self : BioseqalignprofileCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_view_make(size : Int) -> BioseqalignprofileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileView::len(self : BioseqalignprofileView) -> Int { self.size }

pub fn BioseqalignprofileView::get(self : BioseqalignprofileView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileView::set(self : BioseqalignprofileView, i : Int, v : Double) -> BioseqalignprofileView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileView::sum(self : BioseqalignprofileView) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileView::mean(self : BioseqalignprofileView) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileView::scale(self : BioseqalignprofileView, f : Double) -> BioseqalignprofileView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileView::add(self : BioseqalignprofileView, other : BioseqalignprofileView) -> BioseqalignprofileView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileView::copy(self : BioseqalignprofileView) -> BioseqalignprofileView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileView::fill(self : BioseqalignprofileView, v : Double) -> BioseqalignprofileView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileView::min(self : BioseqalignprofileView) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileView::max(self : BioseqalignprofileView) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileView::to_string(self : BioseqalignprofileView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_range_make(size : Int) -> BioseqalignprofileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileRange::len(self : BioseqalignprofileRange) -> Int { self.size }

pub fn BioseqalignprofileRange::get(self : BioseqalignprofileRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileRange::set(self : BioseqalignprofileRange, i : Int, v : Double) -> BioseqalignprofileRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileRange::sum(self : BioseqalignprofileRange) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileRange::mean(self : BioseqalignprofileRange) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileRange::scale(self : BioseqalignprofileRange, f : Double) -> BioseqalignprofileRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileRange::add(self : BioseqalignprofileRange, other : BioseqalignprofileRange) -> BioseqalignprofileRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileRange::copy(self : BioseqalignprofileRange) -> BioseqalignprofileRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileRange::fill(self : BioseqalignprofileRange, v : Double) -> BioseqalignprofileRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileRange::min(self : BioseqalignprofileRange) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileRange::max(self : BioseqalignprofileRange) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileRange::to_string(self : BioseqalignprofileRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_slice_make(size : Int) -> BioseqalignprofileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignprofileSlice::len(self : BioseqalignprofileSlice) -> Int { self.size }

pub fn BioseqalignprofileSlice::get(self : BioseqalignprofileSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignprofileSlice::set(self : BioseqalignprofileSlice, i : Int, v : Double) -> BioseqalignprofileSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileSlice::sum(self : BioseqalignprofileSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqalignprofileSlice::mean(self : BioseqalignprofileSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqalignprofileSlice::scale(self : BioseqalignprofileSlice, f : Double) -> BioseqalignprofileSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileSlice::add(self : BioseqalignprofileSlice, other : BioseqalignprofileSlice) -> BioseqalignprofileSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignprofileSlice::copy(self : BioseqalignprofileSlice) -> BioseqalignprofileSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileSlice::fill(self : BioseqalignprofileSlice, v : Double) -> BioseqalignprofileSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignprofileSlice::min(self : BioseqalignprofileSlice) -> Double { @_common.min(self.data) }

pub fn BioseqalignprofileSlice::max(self : BioseqalignprofileSlice) -> Double { @_common.max(self.data) }

pub fn BioseqalignprofileSlice::to_string(self : BioseqalignprofileSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

