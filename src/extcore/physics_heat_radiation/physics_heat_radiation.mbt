///===
/// extcore/physics_heat_radiation

pub(all) struct PhysicsheatradiationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_radiation_make_point(x : Double, y : Double) -> PhysicsheatradiationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_radiation_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatradiationPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatradiationPoint::x(self : PhysicsheatradiationPoint) -> Double { self.x }

pub fn PhysicsheatradiationPoint::y(self : PhysicsheatradiationPoint) -> Double { self.y }

pub fn PhysicsheatradiationPoint::z(self : PhysicsheatradiationPoint) -> Double { self.z }

pub fn PhysicsheatradiationPoint::label(self : PhysicsheatradiationPoint) -> Int { self.label }

pub fn PhysicsheatradiationPoint::dist(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatradiationPoint::add(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatradiationPoint::sub(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatradiationPoint::scale(self : PhysicsheatradiationPoint, s : Double) -> PhysicsheatradiationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatradiationPoint::dot(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatradiationPoint::cross(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatradiationPoint::norm(self : PhysicsheatradiationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatradiationPoint::normalize(self : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatradiationPoint::negate(self : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatradiationPoint::mid(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatradiationPoint::lerp(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint, t : Double) -> PhysicsheatradiationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatradiationPoint::to_string(self : PhysicsheatradiationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatradiationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_radiation_make_series(vals : Array[Double], name : String) -> PhysicsheatradiationSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatradiationSeries::len(self : PhysicsheatradiationSeries) -> Int { self.vals.length() }

pub fn PhysicsheatradiationSeries::sum(self : PhysicsheatradiationSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatradiationSeries::mean(self : PhysicsheatradiationSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatradiationSeries::min(self : PhysicsheatradiationSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatradiationSeries::max(self : PhysicsheatradiationSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatradiationSeries::range(self : PhysicsheatradiationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatradiationSeries::variance(self : PhysicsheatradiationSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatradiationSeries::std(self : PhysicsheatradiationSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatradiationSeries::median(self : PhysicsheatradiationSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatradiationSeries::scale(self : PhysicsheatradiationSeries, f : Double) -> PhysicsheatradiationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatradiationSeries::add(self : PhysicsheatradiationSeries, other : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatradiationSeries::sub(self : PhysicsheatradiationSeries, other : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatradiationSeries::normalize(self : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatradiationSeries::cumsum(self : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatradiationSeries::to_string(self : PhysicsheatradiationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatradiationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_radiation_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatradiationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_radiation_matrix_identity(n : Int) -> PhysicsheatradiationMatrix {
  let m = physics_heat_radiation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatradiationMatrix::get(self : PhysicsheatradiationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatradiationMatrix::transpose(self : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  let result = physics_heat_radiation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatradiationMatrix::add(self : PhysicsheatradiationMatrix, other : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_radiation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatradiationMatrix::scale(self : PhysicsheatradiationMatrix, s : Double) -> PhysicsheatradiationMatrix {
  let result = physics_heat_radiation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatradiationMatrix::multiply(self : PhysicsheatradiationMatrix, other : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  if self.cols != other.rows { return physics_heat_radiation_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_radiation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatradiationMatrix::trace(self : PhysicsheatradiationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatradiationMatrix::det(self : PhysicsheatradiationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatradiationMatrix::norm(self : PhysicsheatradiationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatradiationMatrix::to_string(self : PhysicsheatradiationMatrix) -> String {
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

pub(all) struct PhysicsheatradiationVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_radiation_make_vector(comps : Array[Double]) -> PhysicsheatradiationVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_radiation_vector_zero(dim : Int) -> PhysicsheatradiationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatradiationVector::add(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatradiationVector::sub(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatradiationVector::scale(self : PhysicsheatradiationVector, s : Double) -> PhysicsheatradiationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatradiationVector::dot(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatradiationVector::norm(self : PhysicsheatradiationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatradiationVector::normalize(self : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatradiationVector::dist(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatradiationVector::to_string(self : PhysicsheatradiationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_radiation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_radiation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_radiation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_radiation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_radiation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_radiation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_radiation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_radiation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_radiation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_radiation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_radiation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_radiation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_radiation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_radiation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_radiation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_radiation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_radiation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_radiation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_radiation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_radiation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_radiation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_radiation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_radiation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_radiation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_radiation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_radiation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_radiation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_radiation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_radiation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatradiationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_frame_make(size : Int) -> PhysicsheatradiationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_frame_len(s : PhysicsheatradiationFrame) -> Int { s.size }

pub fn physics_heat_radiation_frame_get(s : PhysicsheatradiationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_frame_set(s : PhysicsheatradiationFrame, i : Int, v : Double) -> PhysicsheatradiationFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_frame_sum(s : PhysicsheatradiationFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_frame_mean(s : PhysicsheatradiationFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_frame_scale(s : PhysicsheatradiationFrame, f : Double) -> PhysicsheatradiationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_frame_add(a : PhysicsheatradiationFrame, b : PhysicsheatradiationFrame) -> PhysicsheatradiationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_frame_copy(s : PhysicsheatradiationFrame) -> PhysicsheatradiationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_frame_fill(s : PhysicsheatradiationFrame, v : Double) -> PhysicsheatradiationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_frame_min(s : PhysicsheatradiationFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_frame_max(s : PhysicsheatradiationFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_frame_to_string(s : PhysicsheatradiationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_table_make(size : Int) -> PhysicsheatradiationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_table_len(s : PhysicsheatradiationTable) -> Int { s.size }

pub fn physics_heat_radiation_table_get(s : PhysicsheatradiationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_table_set(s : PhysicsheatradiationTable, i : Int, v : Double) -> PhysicsheatradiationTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_table_sum(s : PhysicsheatradiationTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_table_mean(s : PhysicsheatradiationTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_table_scale(s : PhysicsheatradiationTable, f : Double) -> PhysicsheatradiationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_table_add(a : PhysicsheatradiationTable, b : PhysicsheatradiationTable) -> PhysicsheatradiationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_table_copy(s : PhysicsheatradiationTable) -> PhysicsheatradiationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_table_fill(s : PhysicsheatradiationTable, v : Double) -> PhysicsheatradiationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_table_min(s : PhysicsheatradiationTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_table_max(s : PhysicsheatradiationTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_table_to_string(s : PhysicsheatradiationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_graphn_make(size : Int) -> PhysicsheatradiationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_graphn_len(s : PhysicsheatradiationGraphN) -> Int { s.size }

pub fn physics_heat_radiation_graphn_get(s : PhysicsheatradiationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_graphn_set(s : PhysicsheatradiationGraphN, i : Int, v : Double) -> PhysicsheatradiationGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_graphn_sum(s : PhysicsheatradiationGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_graphn_mean(s : PhysicsheatradiationGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_graphn_scale(s : PhysicsheatradiationGraphN, f : Double) -> PhysicsheatradiationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_graphn_add(a : PhysicsheatradiationGraphN, b : PhysicsheatradiationGraphN) -> PhysicsheatradiationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_graphn_copy(s : PhysicsheatradiationGraphN) -> PhysicsheatradiationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_graphn_fill(s : PhysicsheatradiationGraphN, v : Double) -> PhysicsheatradiationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_graphn_min(s : PhysicsheatradiationGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_graphn_max(s : PhysicsheatradiationGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_graphn_to_string(s : PhysicsheatradiationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_node_make(size : Int) -> PhysicsheatradiationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_node_len(s : PhysicsheatradiationNode) -> Int { s.size }

pub fn physics_heat_radiation_node_get(s : PhysicsheatradiationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_node_set(s : PhysicsheatradiationNode, i : Int, v : Double) -> PhysicsheatradiationNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_node_sum(s : PhysicsheatradiationNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_node_mean(s : PhysicsheatradiationNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_node_scale(s : PhysicsheatradiationNode, f : Double) -> PhysicsheatradiationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_node_add(a : PhysicsheatradiationNode, b : PhysicsheatradiationNode) -> PhysicsheatradiationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_node_copy(s : PhysicsheatradiationNode) -> PhysicsheatradiationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_node_fill(s : PhysicsheatradiationNode, v : Double) -> PhysicsheatradiationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_node_min(s : PhysicsheatradiationNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_node_max(s : PhysicsheatradiationNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_node_to_string(s : PhysicsheatradiationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_edge_make(size : Int) -> PhysicsheatradiationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_edge_len(s : PhysicsheatradiationEdge) -> Int { s.size }

pub fn physics_heat_radiation_edge_get(s : PhysicsheatradiationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_edge_set(s : PhysicsheatradiationEdge, i : Int, v : Double) -> PhysicsheatradiationEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_edge_sum(s : PhysicsheatradiationEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_edge_mean(s : PhysicsheatradiationEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_edge_scale(s : PhysicsheatradiationEdge, f : Double) -> PhysicsheatradiationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_edge_add(a : PhysicsheatradiationEdge, b : PhysicsheatradiationEdge) -> PhysicsheatradiationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_edge_copy(s : PhysicsheatradiationEdge) -> PhysicsheatradiationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_edge_fill(s : PhysicsheatradiationEdge, v : Double) -> PhysicsheatradiationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_edge_min(s : PhysicsheatradiationEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_edge_max(s : PhysicsheatradiationEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_edge_to_string(s : PhysicsheatradiationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_path_make(size : Int) -> PhysicsheatradiationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_path_len(s : PhysicsheatradiationPath) -> Int { s.size }

pub fn physics_heat_radiation_path_get(s : PhysicsheatradiationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_path_set(s : PhysicsheatradiationPath, i : Int, v : Double) -> PhysicsheatradiationPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_path_sum(s : PhysicsheatradiationPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_path_mean(s : PhysicsheatradiationPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_path_scale(s : PhysicsheatradiationPath, f : Double) -> PhysicsheatradiationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_path_add(a : PhysicsheatradiationPath, b : PhysicsheatradiationPath) -> PhysicsheatradiationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_path_copy(s : PhysicsheatradiationPath) -> PhysicsheatradiationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_path_fill(s : PhysicsheatradiationPath, v : Double) -> PhysicsheatradiationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_path_min(s : PhysicsheatradiationPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_path_max(s : PhysicsheatradiationPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_path_to_string(s : PhysicsheatradiationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_cluster_make(size : Int) -> PhysicsheatradiationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_cluster_len(s : PhysicsheatradiationCluster) -> Int { s.size }

pub fn physics_heat_radiation_cluster_get(s : PhysicsheatradiationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_cluster_set(s : PhysicsheatradiationCluster, i : Int, v : Double) -> PhysicsheatradiationCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cluster_sum(s : PhysicsheatradiationCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_cluster_mean(s : PhysicsheatradiationCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_cluster_scale(s : PhysicsheatradiationCluster, f : Double) -> PhysicsheatradiationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cluster_add(a : PhysicsheatradiationCluster, b : PhysicsheatradiationCluster) -> PhysicsheatradiationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_cluster_copy(s : PhysicsheatradiationCluster) -> PhysicsheatradiationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cluster_fill(s : PhysicsheatradiationCluster, v : Double) -> PhysicsheatradiationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cluster_min(s : PhysicsheatradiationCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_cluster_max(s : PhysicsheatradiationCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_cluster_to_string(s : PhysicsheatradiationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_model_make(size : Int) -> PhysicsheatradiationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_model_len(s : PhysicsheatradiationModel) -> Int { s.size }

pub fn physics_heat_radiation_model_get(s : PhysicsheatradiationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_model_set(s : PhysicsheatradiationModel, i : Int, v : Double) -> PhysicsheatradiationModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_model_sum(s : PhysicsheatradiationModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_model_mean(s : PhysicsheatradiationModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_model_scale(s : PhysicsheatradiationModel, f : Double) -> PhysicsheatradiationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_model_add(a : PhysicsheatradiationModel, b : PhysicsheatradiationModel) -> PhysicsheatradiationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_model_copy(s : PhysicsheatradiationModel) -> PhysicsheatradiationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_model_fill(s : PhysicsheatradiationModel, v : Double) -> PhysicsheatradiationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_model_min(s : PhysicsheatradiationModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_model_max(s : PhysicsheatradiationModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_model_to_string(s : PhysicsheatradiationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_layer_make(size : Int) -> PhysicsheatradiationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_layer_len(s : PhysicsheatradiationLayer) -> Int { s.size }

pub fn physics_heat_radiation_layer_get(s : PhysicsheatradiationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_layer_set(s : PhysicsheatradiationLayer, i : Int, v : Double) -> PhysicsheatradiationLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_layer_sum(s : PhysicsheatradiationLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_layer_mean(s : PhysicsheatradiationLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_layer_scale(s : PhysicsheatradiationLayer, f : Double) -> PhysicsheatradiationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_layer_add(a : PhysicsheatradiationLayer, b : PhysicsheatradiationLayer) -> PhysicsheatradiationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_layer_copy(s : PhysicsheatradiationLayer) -> PhysicsheatradiationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_layer_fill(s : PhysicsheatradiationLayer, v : Double) -> PhysicsheatradiationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_layer_min(s : PhysicsheatradiationLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_layer_max(s : PhysicsheatradiationLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_layer_to_string(s : PhysicsheatradiationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_buffer_make(size : Int) -> PhysicsheatradiationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_buffer_len(s : PhysicsheatradiationBuffer) -> Int { s.size }

pub fn physics_heat_radiation_buffer_get(s : PhysicsheatradiationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_buffer_set(s : PhysicsheatradiationBuffer, i : Int, v : Double) -> PhysicsheatradiationBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_buffer_sum(s : PhysicsheatradiationBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_buffer_mean(s : PhysicsheatradiationBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_buffer_scale(s : PhysicsheatradiationBuffer, f : Double) -> PhysicsheatradiationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_buffer_add(a : PhysicsheatradiationBuffer, b : PhysicsheatradiationBuffer) -> PhysicsheatradiationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_buffer_copy(s : PhysicsheatradiationBuffer) -> PhysicsheatradiationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_buffer_fill(s : PhysicsheatradiationBuffer, v : Double) -> PhysicsheatradiationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_buffer_min(s : PhysicsheatradiationBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_buffer_max(s : PhysicsheatradiationBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_buffer_to_string(s : PhysicsheatradiationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_cursor_make(size : Int) -> PhysicsheatradiationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_cursor_len(s : PhysicsheatradiationCursor) -> Int { s.size }

pub fn physics_heat_radiation_cursor_get(s : PhysicsheatradiationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_cursor_set(s : PhysicsheatradiationCursor, i : Int, v : Double) -> PhysicsheatradiationCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cursor_sum(s : PhysicsheatradiationCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_cursor_mean(s : PhysicsheatradiationCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_cursor_scale(s : PhysicsheatradiationCursor, f : Double) -> PhysicsheatradiationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cursor_add(a : PhysicsheatradiationCursor, b : PhysicsheatradiationCursor) -> PhysicsheatradiationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_cursor_copy(s : PhysicsheatradiationCursor) -> PhysicsheatradiationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cursor_fill(s : PhysicsheatradiationCursor, v : Double) -> PhysicsheatradiationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_cursor_min(s : PhysicsheatradiationCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_cursor_max(s : PhysicsheatradiationCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_cursor_to_string(s : PhysicsheatradiationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_view_make(size : Int) -> PhysicsheatradiationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_view_len(s : PhysicsheatradiationView) -> Int { s.size }

pub fn physics_heat_radiation_view_get(s : PhysicsheatradiationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_view_set(s : PhysicsheatradiationView, i : Int, v : Double) -> PhysicsheatradiationView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_view_sum(s : PhysicsheatradiationView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_view_mean(s : PhysicsheatradiationView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_view_scale(s : PhysicsheatradiationView, f : Double) -> PhysicsheatradiationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_view_add(a : PhysicsheatradiationView, b : PhysicsheatradiationView) -> PhysicsheatradiationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_view_copy(s : PhysicsheatradiationView) -> PhysicsheatradiationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_view_fill(s : PhysicsheatradiationView, v : Double) -> PhysicsheatradiationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_view_min(s : PhysicsheatradiationView) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_view_max(s : PhysicsheatradiationView) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_view_to_string(s : PhysicsheatradiationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_range_make(size : Int) -> PhysicsheatradiationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_range_len(s : PhysicsheatradiationRange) -> Int { s.size }

pub fn physics_heat_radiation_range_get(s : PhysicsheatradiationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_range_set(s : PhysicsheatradiationRange, i : Int, v : Double) -> PhysicsheatradiationRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_range_sum(s : PhysicsheatradiationRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_range_mean(s : PhysicsheatradiationRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_range_scale(s : PhysicsheatradiationRange, f : Double) -> PhysicsheatradiationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_range_add(a : PhysicsheatradiationRange, b : PhysicsheatradiationRange) -> PhysicsheatradiationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_range_copy(s : PhysicsheatradiationRange) -> PhysicsheatradiationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_range_fill(s : PhysicsheatradiationRange, v : Double) -> PhysicsheatradiationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_range_min(s : PhysicsheatradiationRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_range_max(s : PhysicsheatradiationRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_range_to_string(s : PhysicsheatradiationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_slice_make(size : Int) -> PhysicsheatradiationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_slice_len(s : PhysicsheatradiationSlice) -> Int { s.size }

pub fn physics_heat_radiation_slice_get(s : PhysicsheatradiationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_slice_set(s : PhysicsheatradiationSlice, i : Int, v : Double) -> PhysicsheatradiationSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_slice_sum(s : PhysicsheatradiationSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_radiation_slice_mean(s : PhysicsheatradiationSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_radiation_slice_scale(s : PhysicsheatradiationSlice, f : Double) -> PhysicsheatradiationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_slice_add(a : PhysicsheatradiationSlice, b : PhysicsheatradiationSlice) -> PhysicsheatradiationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_radiation_slice_copy(s : PhysicsheatradiationSlice) -> PhysicsheatradiationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_slice_fill(s : PhysicsheatradiationSlice, v : Double) -> PhysicsheatradiationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_radiation_slice_min(s : PhysicsheatradiationSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_radiation_slice_max(s : PhysicsheatradiationSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_radiation_slice_to_string(s : PhysicsheatradiationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

