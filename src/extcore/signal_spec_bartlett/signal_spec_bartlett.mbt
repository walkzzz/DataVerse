///===
/// extcore/signal_spec_bartlett

pub(all) struct SignalspecbartlettPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_bartlett_make_point(x : Double, y : Double) -> SignalspecbartlettPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_bartlett_make_point3(x : Double, y : Double, z : Double) -> SignalspecbartlettPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecbartlettPoint::x(self : SignalspecbartlettPoint) -> Double { self.x }

pub fn SignalspecbartlettPoint::y(self : SignalspecbartlettPoint) -> Double { self.y }

pub fn SignalspecbartlettPoint::z(self : SignalspecbartlettPoint) -> Double { self.z }

pub fn SignalspecbartlettPoint::label(self : SignalspecbartlettPoint) -> Int { self.label }

pub fn SignalspecbartlettPoint::dist(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecbartlettPoint::add(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecbartlettPoint::sub(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecbartlettPoint::scale(self : SignalspecbartlettPoint, s : Double) -> SignalspecbartlettPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecbartlettPoint::dot(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecbartlettPoint::cross(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecbartlettPoint::norm(self : SignalspecbartlettPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecbartlettPoint::normalize(self : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecbartlettPoint::negate(self : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecbartlettPoint::mid(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecbartlettPoint::lerp(self : SignalspecbartlettPoint, other : SignalspecbartlettPoint, t : Double) -> SignalspecbartlettPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecbartlettPoint::to_string(self : SignalspecbartlettPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecbartlettSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_bartlett_make_series(vals : Array[Double], name : String) -> SignalspecbartlettSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecbartlettSeries::len(self : SignalspecbartlettSeries) -> Int { self.vals.length() }

pub fn SignalspecbartlettSeries::sum(self : SignalspecbartlettSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecbartlettSeries::mean(self : SignalspecbartlettSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecbartlettSeries::min(self : SignalspecbartlettSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecbartlettSeries::max(self : SignalspecbartlettSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecbartlettSeries::range(self : SignalspecbartlettSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecbartlettSeries::variance(self : SignalspecbartlettSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecbartlettSeries::std(self : SignalspecbartlettSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecbartlettSeries::median(self : SignalspecbartlettSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecbartlettSeries::scale(self : SignalspecbartlettSeries, f : Double) -> SignalspecbartlettSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecbartlettSeries::add(self : SignalspecbartlettSeries, other : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecbartlettSeries::sub(self : SignalspecbartlettSeries, other : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecbartlettSeries::normalize(self : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecbartlettSeries::cumsum(self : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecbartlettSeries::to_string(self : SignalspecbartlettSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecbartlettMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_bartlett_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecbartlettMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_bartlett_matrix_identity(n : Int) -> SignalspecbartlettMatrix {
  let m = signal_spec_bartlett_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecbartlettMatrix::get(self : SignalspecbartlettMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecbartlettMatrix::transpose(self : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  let result = signal_spec_bartlett_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecbartlettMatrix::add(self : SignalspecbartlettMatrix, other : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecbartlettMatrix::scale(self : SignalspecbartlettMatrix, s : Double) -> SignalspecbartlettMatrix {
  let result = signal_spec_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecbartlettMatrix::multiply(self : SignalspecbartlettMatrix, other : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  if self.cols != other.rows { return signal_spec_bartlett_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_bartlett_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecbartlettMatrix::trace(self : SignalspecbartlettMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecbartlettMatrix::det(self : SignalspecbartlettMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecbartlettMatrix::norm(self : SignalspecbartlettMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecbartlettMatrix::to_string(self : SignalspecbartlettMatrix) -> String {
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

pub(all) struct SignalspecbartlettVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_bartlett_make_vector(comps : Array[Double]) -> SignalspecbartlettVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_bartlett_vector_zero(dim : Int) -> SignalspecbartlettVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecbartlettVector::add(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecbartlettVector::sub(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecbartlettVector::scale(self : SignalspecbartlettVector, s : Double) -> SignalspecbartlettVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecbartlettVector::dot(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecbartlettVector::norm(self : SignalspecbartlettVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecbartlettVector::normalize(self : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecbartlettVector::dist(self : SignalspecbartlettVector, other : SignalspecbartlettVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecbartlettVector::to_string(self : SignalspecbartlettVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_bartlett_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_bartlett_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_bartlett_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_bartlett_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_bartlett_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_bartlett_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_bartlett_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_bartlett_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_bartlett_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_bartlett_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_bartlett_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_bartlett_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_bartlett_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_bartlett_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_bartlett_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_bartlett_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_bartlett_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_bartlett_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_bartlett_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_bartlett_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_bartlett_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_bartlett_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_bartlett_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_bartlett_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_bartlett_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_bartlett_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_bartlett_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_bartlett_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_bartlett_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecbartlettFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_frame_make(size : Int) -> SignalspecbartlettFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_frame_len(s : SignalspecbartlettFrame) -> Int { s.size }

pub fn signal_spec_bartlett_frame_get(s : SignalspecbartlettFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_frame_set(s : SignalspecbartlettFrame, i : Int, v : Double) -> SignalspecbartlettFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_frame_sum(s : SignalspecbartlettFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_frame_mean(s : SignalspecbartlettFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_frame_scale(s : SignalspecbartlettFrame, f : Double) -> SignalspecbartlettFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_frame_add(a : SignalspecbartlettFrame, b : SignalspecbartlettFrame) -> SignalspecbartlettFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_frame_copy(s : SignalspecbartlettFrame) -> SignalspecbartlettFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_frame_fill(s : SignalspecbartlettFrame, v : Double) -> SignalspecbartlettFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_frame_min(s : SignalspecbartlettFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_frame_max(s : SignalspecbartlettFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_frame_to_string(s : SignalspecbartlettFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_table_make(size : Int) -> SignalspecbartlettTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_table_len(s : SignalspecbartlettTable) -> Int { s.size }

pub fn signal_spec_bartlett_table_get(s : SignalspecbartlettTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_table_set(s : SignalspecbartlettTable, i : Int, v : Double) -> SignalspecbartlettTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_table_sum(s : SignalspecbartlettTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_table_mean(s : SignalspecbartlettTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_table_scale(s : SignalspecbartlettTable, f : Double) -> SignalspecbartlettTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_table_add(a : SignalspecbartlettTable, b : SignalspecbartlettTable) -> SignalspecbartlettTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_table_copy(s : SignalspecbartlettTable) -> SignalspecbartlettTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_table_fill(s : SignalspecbartlettTable, v : Double) -> SignalspecbartlettTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_table_min(s : SignalspecbartlettTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_table_max(s : SignalspecbartlettTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_table_to_string(s : SignalspecbartlettTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_graphn_make(size : Int) -> SignalspecbartlettGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_graphn_len(s : SignalspecbartlettGraphN) -> Int { s.size }

pub fn signal_spec_bartlett_graphn_get(s : SignalspecbartlettGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_graphn_set(s : SignalspecbartlettGraphN, i : Int, v : Double) -> SignalspecbartlettGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_graphn_sum(s : SignalspecbartlettGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_graphn_mean(s : SignalspecbartlettGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_graphn_scale(s : SignalspecbartlettGraphN, f : Double) -> SignalspecbartlettGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_graphn_add(a : SignalspecbartlettGraphN, b : SignalspecbartlettGraphN) -> SignalspecbartlettGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_graphn_copy(s : SignalspecbartlettGraphN) -> SignalspecbartlettGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_graphn_fill(s : SignalspecbartlettGraphN, v : Double) -> SignalspecbartlettGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_graphn_min(s : SignalspecbartlettGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_graphn_max(s : SignalspecbartlettGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_graphn_to_string(s : SignalspecbartlettGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_node_make(size : Int) -> SignalspecbartlettNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_node_len(s : SignalspecbartlettNode) -> Int { s.size }

pub fn signal_spec_bartlett_node_get(s : SignalspecbartlettNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_node_set(s : SignalspecbartlettNode, i : Int, v : Double) -> SignalspecbartlettNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_node_sum(s : SignalspecbartlettNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_node_mean(s : SignalspecbartlettNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_node_scale(s : SignalspecbartlettNode, f : Double) -> SignalspecbartlettNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_node_add(a : SignalspecbartlettNode, b : SignalspecbartlettNode) -> SignalspecbartlettNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_node_copy(s : SignalspecbartlettNode) -> SignalspecbartlettNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_node_fill(s : SignalspecbartlettNode, v : Double) -> SignalspecbartlettNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_node_min(s : SignalspecbartlettNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_node_max(s : SignalspecbartlettNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_node_to_string(s : SignalspecbartlettNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_edge_make(size : Int) -> SignalspecbartlettEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_edge_len(s : SignalspecbartlettEdge) -> Int { s.size }

pub fn signal_spec_bartlett_edge_get(s : SignalspecbartlettEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_edge_set(s : SignalspecbartlettEdge, i : Int, v : Double) -> SignalspecbartlettEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_edge_sum(s : SignalspecbartlettEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_edge_mean(s : SignalspecbartlettEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_edge_scale(s : SignalspecbartlettEdge, f : Double) -> SignalspecbartlettEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_edge_add(a : SignalspecbartlettEdge, b : SignalspecbartlettEdge) -> SignalspecbartlettEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_edge_copy(s : SignalspecbartlettEdge) -> SignalspecbartlettEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_edge_fill(s : SignalspecbartlettEdge, v : Double) -> SignalspecbartlettEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_edge_min(s : SignalspecbartlettEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_edge_max(s : SignalspecbartlettEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_edge_to_string(s : SignalspecbartlettEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_path_make(size : Int) -> SignalspecbartlettPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_path_len(s : SignalspecbartlettPath) -> Int { s.size }

pub fn signal_spec_bartlett_path_get(s : SignalspecbartlettPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_path_set(s : SignalspecbartlettPath, i : Int, v : Double) -> SignalspecbartlettPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_path_sum(s : SignalspecbartlettPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_path_mean(s : SignalspecbartlettPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_path_scale(s : SignalspecbartlettPath, f : Double) -> SignalspecbartlettPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_path_add(a : SignalspecbartlettPath, b : SignalspecbartlettPath) -> SignalspecbartlettPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_path_copy(s : SignalspecbartlettPath) -> SignalspecbartlettPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_path_fill(s : SignalspecbartlettPath, v : Double) -> SignalspecbartlettPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_path_min(s : SignalspecbartlettPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_path_max(s : SignalspecbartlettPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_path_to_string(s : SignalspecbartlettPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_cluster_make(size : Int) -> SignalspecbartlettCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_cluster_len(s : SignalspecbartlettCluster) -> Int { s.size }

pub fn signal_spec_bartlett_cluster_get(s : SignalspecbartlettCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_cluster_set(s : SignalspecbartlettCluster, i : Int, v : Double) -> SignalspecbartlettCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cluster_sum(s : SignalspecbartlettCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_cluster_mean(s : SignalspecbartlettCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_cluster_scale(s : SignalspecbartlettCluster, f : Double) -> SignalspecbartlettCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cluster_add(a : SignalspecbartlettCluster, b : SignalspecbartlettCluster) -> SignalspecbartlettCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_cluster_copy(s : SignalspecbartlettCluster) -> SignalspecbartlettCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cluster_fill(s : SignalspecbartlettCluster, v : Double) -> SignalspecbartlettCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cluster_min(s : SignalspecbartlettCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_cluster_max(s : SignalspecbartlettCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_cluster_to_string(s : SignalspecbartlettCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_model_make(size : Int) -> SignalspecbartlettModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_model_len(s : SignalspecbartlettModel) -> Int { s.size }

pub fn signal_spec_bartlett_model_get(s : SignalspecbartlettModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_model_set(s : SignalspecbartlettModel, i : Int, v : Double) -> SignalspecbartlettModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_model_sum(s : SignalspecbartlettModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_model_mean(s : SignalspecbartlettModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_model_scale(s : SignalspecbartlettModel, f : Double) -> SignalspecbartlettModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_model_add(a : SignalspecbartlettModel, b : SignalspecbartlettModel) -> SignalspecbartlettModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_model_copy(s : SignalspecbartlettModel) -> SignalspecbartlettModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_model_fill(s : SignalspecbartlettModel, v : Double) -> SignalspecbartlettModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_model_min(s : SignalspecbartlettModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_model_max(s : SignalspecbartlettModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_model_to_string(s : SignalspecbartlettModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_layer_make(size : Int) -> SignalspecbartlettLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_layer_len(s : SignalspecbartlettLayer) -> Int { s.size }

pub fn signal_spec_bartlett_layer_get(s : SignalspecbartlettLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_layer_set(s : SignalspecbartlettLayer, i : Int, v : Double) -> SignalspecbartlettLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_layer_sum(s : SignalspecbartlettLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_layer_mean(s : SignalspecbartlettLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_layer_scale(s : SignalspecbartlettLayer, f : Double) -> SignalspecbartlettLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_layer_add(a : SignalspecbartlettLayer, b : SignalspecbartlettLayer) -> SignalspecbartlettLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_layer_copy(s : SignalspecbartlettLayer) -> SignalspecbartlettLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_layer_fill(s : SignalspecbartlettLayer, v : Double) -> SignalspecbartlettLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_layer_min(s : SignalspecbartlettLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_layer_max(s : SignalspecbartlettLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_layer_to_string(s : SignalspecbartlettLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_buffer_make(size : Int) -> SignalspecbartlettBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_buffer_len(s : SignalspecbartlettBuffer) -> Int { s.size }

pub fn signal_spec_bartlett_buffer_get(s : SignalspecbartlettBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_buffer_set(s : SignalspecbartlettBuffer, i : Int, v : Double) -> SignalspecbartlettBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_buffer_sum(s : SignalspecbartlettBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_buffer_mean(s : SignalspecbartlettBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_buffer_scale(s : SignalspecbartlettBuffer, f : Double) -> SignalspecbartlettBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_buffer_add(a : SignalspecbartlettBuffer, b : SignalspecbartlettBuffer) -> SignalspecbartlettBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_buffer_copy(s : SignalspecbartlettBuffer) -> SignalspecbartlettBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_buffer_fill(s : SignalspecbartlettBuffer, v : Double) -> SignalspecbartlettBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_buffer_min(s : SignalspecbartlettBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_buffer_max(s : SignalspecbartlettBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_buffer_to_string(s : SignalspecbartlettBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_cursor_make(size : Int) -> SignalspecbartlettCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_cursor_len(s : SignalspecbartlettCursor) -> Int { s.size }

pub fn signal_spec_bartlett_cursor_get(s : SignalspecbartlettCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_cursor_set(s : SignalspecbartlettCursor, i : Int, v : Double) -> SignalspecbartlettCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cursor_sum(s : SignalspecbartlettCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_cursor_mean(s : SignalspecbartlettCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_cursor_scale(s : SignalspecbartlettCursor, f : Double) -> SignalspecbartlettCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cursor_add(a : SignalspecbartlettCursor, b : SignalspecbartlettCursor) -> SignalspecbartlettCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_cursor_copy(s : SignalspecbartlettCursor) -> SignalspecbartlettCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cursor_fill(s : SignalspecbartlettCursor, v : Double) -> SignalspecbartlettCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cursor_min(s : SignalspecbartlettCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_cursor_max(s : SignalspecbartlettCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_cursor_to_string(s : SignalspecbartlettCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_view_make(size : Int) -> SignalspecbartlettView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_view_len(s : SignalspecbartlettView) -> Int { s.size }

pub fn signal_spec_bartlett_view_get(s : SignalspecbartlettView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_view_set(s : SignalspecbartlettView, i : Int, v : Double) -> SignalspecbartlettView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_view_sum(s : SignalspecbartlettView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_view_mean(s : SignalspecbartlettView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_view_scale(s : SignalspecbartlettView, f : Double) -> SignalspecbartlettView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_view_add(a : SignalspecbartlettView, b : SignalspecbartlettView) -> SignalspecbartlettView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_view_copy(s : SignalspecbartlettView) -> SignalspecbartlettView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_view_fill(s : SignalspecbartlettView, v : Double) -> SignalspecbartlettView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_view_min(s : SignalspecbartlettView) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_view_max(s : SignalspecbartlettView) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_view_to_string(s : SignalspecbartlettView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_range_make(size : Int) -> SignalspecbartlettRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_range_len(s : SignalspecbartlettRange) -> Int { s.size }

pub fn signal_spec_bartlett_range_get(s : SignalspecbartlettRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_range_set(s : SignalspecbartlettRange, i : Int, v : Double) -> SignalspecbartlettRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_range_sum(s : SignalspecbartlettRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_range_mean(s : SignalspecbartlettRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_range_scale(s : SignalspecbartlettRange, f : Double) -> SignalspecbartlettRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_range_add(a : SignalspecbartlettRange, b : SignalspecbartlettRange) -> SignalspecbartlettRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_range_copy(s : SignalspecbartlettRange) -> SignalspecbartlettRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_range_fill(s : SignalspecbartlettRange, v : Double) -> SignalspecbartlettRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_range_min(s : SignalspecbartlettRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_range_max(s : SignalspecbartlettRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_range_to_string(s : SignalspecbartlettRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_slice_make(size : Int) -> SignalspecbartlettSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_slice_len(s : SignalspecbartlettSlice) -> Int { s.size }

pub fn signal_spec_bartlett_slice_get(s : SignalspecbartlettSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_slice_set(s : SignalspecbartlettSlice, i : Int, v : Double) -> SignalspecbartlettSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_slice_sum(s : SignalspecbartlettSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_slice_mean(s : SignalspecbartlettSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_slice_scale(s : SignalspecbartlettSlice, f : Double) -> SignalspecbartlettSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_slice_add(a : SignalspecbartlettSlice, b : SignalspecbartlettSlice) -> SignalspecbartlettSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_slice_copy(s : SignalspecbartlettSlice) -> SignalspecbartlettSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_slice_fill(s : SignalspecbartlettSlice, v : Double) -> SignalspecbartlettSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_slice_min(s : SignalspecbartlettSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_slice_max(s : SignalspecbartlettSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_slice_to_string(s : SignalspecbartlettSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

