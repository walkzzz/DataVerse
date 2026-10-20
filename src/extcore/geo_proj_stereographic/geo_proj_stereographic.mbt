///===
/// extcore/geo_proj_stereographic

pub(all) struct GeoprojstereographicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_stereographic_make_point(x : Double, y : Double) -> GeoprojstereographicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_stereographic_make_point3(x : Double, y : Double, z : Double) -> GeoprojstereographicPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojstereographicPoint::x(self : GeoprojstereographicPoint) -> Double { self.x }

pub fn GeoprojstereographicPoint::y(self : GeoprojstereographicPoint) -> Double { self.y }

pub fn GeoprojstereographicPoint::z(self : GeoprojstereographicPoint) -> Double { self.z }

pub fn GeoprojstereographicPoint::label(self : GeoprojstereographicPoint) -> Int { self.label }

pub fn GeoprojstereographicPoint::dist(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojstereographicPoint::add(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojstereographicPoint::sub(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojstereographicPoint::scale(self : GeoprojstereographicPoint, s : Double) -> GeoprojstereographicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojstereographicPoint::dot(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojstereographicPoint::cross(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojstereographicPoint::norm(self : GeoprojstereographicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojstereographicPoint::normalize(self : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojstereographicPoint::negate(self : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojstereographicPoint::mid(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojstereographicPoint::lerp(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint, t : Double) -> GeoprojstereographicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojstereographicPoint::to_string(self : GeoprojstereographicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojstereographicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_stereographic_make_series(vals : Array[Double], name : String) -> GeoprojstereographicSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojstereographicSeries::len(self : GeoprojstereographicSeries) -> Int { self.vals.length() }

pub fn GeoprojstereographicSeries::sum(self : GeoprojstereographicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojstereographicSeries::mean(self : GeoprojstereographicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojstereographicSeries::min(self : GeoprojstereographicSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojstereographicSeries::max(self : GeoprojstereographicSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojstereographicSeries::range(self : GeoprojstereographicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojstereographicSeries::variance(self : GeoprojstereographicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojstereographicSeries::std(self : GeoprojstereographicSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojstereographicSeries::median(self : GeoprojstereographicSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojstereographicSeries::scale(self : GeoprojstereographicSeries, f : Double) -> GeoprojstereographicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojstereographicSeries::add(self : GeoprojstereographicSeries, other : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojstereographicSeries::sub(self : GeoprojstereographicSeries, other : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojstereographicSeries::normalize(self : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojstereographicSeries::cumsum(self : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojstereographicSeries::to_string(self : GeoprojstereographicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojstereographicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_stereographic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojstereographicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_stereographic_matrix_identity(n : Int) -> GeoprojstereographicMatrix {
  let m = geo_proj_stereographic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojstereographicMatrix::get(self : GeoprojstereographicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojstereographicMatrix::transpose(self : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  let result = geo_proj_stereographic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojstereographicMatrix::add(self : GeoprojstereographicMatrix, other : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_stereographic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojstereographicMatrix::scale(self : GeoprojstereographicMatrix, s : Double) -> GeoprojstereographicMatrix {
  let result = geo_proj_stereographic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojstereographicMatrix::multiply(self : GeoprojstereographicMatrix, other : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  if self.cols != other.rows { return geo_proj_stereographic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_stereographic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojstereographicMatrix::trace(self : GeoprojstereographicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojstereographicMatrix::det(self : GeoprojstereographicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojstereographicMatrix::norm(self : GeoprojstereographicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojstereographicMatrix::to_string(self : GeoprojstereographicMatrix) -> String {
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

pub(all) struct GeoprojstereographicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_stereographic_make_vector(comps : Array[Double]) -> GeoprojstereographicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_stereographic_vector_zero(dim : Int) -> GeoprojstereographicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojstereographicVector::add(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojstereographicVector::sub(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojstereographicVector::scale(self : GeoprojstereographicVector, s : Double) -> GeoprojstereographicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojstereographicVector::dot(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojstereographicVector::norm(self : GeoprojstereographicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojstereographicVector::normalize(self : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojstereographicVector::dist(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojstereographicVector::to_string(self : GeoprojstereographicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_stereographic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_stereographic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_stereographic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_stereographic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_stereographic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_stereographic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_stereographic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_stereographic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_stereographic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_stereographic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_stereographic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_stereographic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_stereographic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_stereographic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_stereographic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_stereographic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_stereographic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_stereographic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_stereographic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_stereographic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_stereographic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_stereographic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_stereographic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_stereographic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_stereographic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_stereographic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_stereographic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_stereographic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_stereographic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojstereographicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_frame_make(size : Int) -> GeoprojstereographicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicFrame::len(self : GeoprojstereographicFrame) -> Int { self.size }

pub fn GeoprojstereographicFrame::get(self : GeoprojstereographicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicFrame::set(self : GeoprojstereographicFrame, i : Int, v : Double) -> GeoprojstereographicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicFrame::sum(self : GeoprojstereographicFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicFrame::mean(self : GeoprojstereographicFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicFrame::scale(self : GeoprojstereographicFrame, f : Double) -> GeoprojstereographicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicFrame::add(self : GeoprojstereographicFrame, other : GeoprojstereographicFrame) -> GeoprojstereographicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicFrame::copy(self : GeoprojstereographicFrame) -> GeoprojstereographicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicFrame::fill(self : GeoprojstereographicFrame, v : Double) -> GeoprojstereographicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicFrame::min(self : GeoprojstereographicFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicFrame::max(self : GeoprojstereographicFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicFrame::to_string(self : GeoprojstereographicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_table_make(size : Int) -> GeoprojstereographicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicTable::len(self : GeoprojstereographicTable) -> Int { self.size }

pub fn GeoprojstereographicTable::get(self : GeoprojstereographicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicTable::set(self : GeoprojstereographicTable, i : Int, v : Double) -> GeoprojstereographicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicTable::sum(self : GeoprojstereographicTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicTable::mean(self : GeoprojstereographicTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicTable::scale(self : GeoprojstereographicTable, f : Double) -> GeoprojstereographicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicTable::add(self : GeoprojstereographicTable, other : GeoprojstereographicTable) -> GeoprojstereographicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicTable::copy(self : GeoprojstereographicTable) -> GeoprojstereographicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicTable::fill(self : GeoprojstereographicTable, v : Double) -> GeoprojstereographicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicTable::min(self : GeoprojstereographicTable) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicTable::max(self : GeoprojstereographicTable) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicTable::to_string(self : GeoprojstereographicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_graphn_make(size : Int) -> GeoprojstereographicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicGraphN::len(self : GeoprojstereographicGraphN) -> Int { self.size }

pub fn GeoprojstereographicGraphN::get(self : GeoprojstereographicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicGraphN::set(self : GeoprojstereographicGraphN, i : Int, v : Double) -> GeoprojstereographicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicGraphN::sum(self : GeoprojstereographicGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicGraphN::mean(self : GeoprojstereographicGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicGraphN::scale(self : GeoprojstereographicGraphN, f : Double) -> GeoprojstereographicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicGraphN::add(self : GeoprojstereographicGraphN, other : GeoprojstereographicGraphN) -> GeoprojstereographicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicGraphN::copy(self : GeoprojstereographicGraphN) -> GeoprojstereographicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicGraphN::fill(self : GeoprojstereographicGraphN, v : Double) -> GeoprojstereographicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicGraphN::min(self : GeoprojstereographicGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicGraphN::max(self : GeoprojstereographicGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicGraphN::to_string(self : GeoprojstereographicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_node_make(size : Int) -> GeoprojstereographicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicNode::len(self : GeoprojstereographicNode) -> Int { self.size }

pub fn GeoprojstereographicNode::get(self : GeoprojstereographicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicNode::set(self : GeoprojstereographicNode, i : Int, v : Double) -> GeoprojstereographicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicNode::sum(self : GeoprojstereographicNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicNode::mean(self : GeoprojstereographicNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicNode::scale(self : GeoprojstereographicNode, f : Double) -> GeoprojstereographicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicNode::add(self : GeoprojstereographicNode, other : GeoprojstereographicNode) -> GeoprojstereographicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicNode::copy(self : GeoprojstereographicNode) -> GeoprojstereographicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicNode::fill(self : GeoprojstereographicNode, v : Double) -> GeoprojstereographicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicNode::min(self : GeoprojstereographicNode) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicNode::max(self : GeoprojstereographicNode) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicNode::to_string(self : GeoprojstereographicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_edge_make(size : Int) -> GeoprojstereographicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicEdge::len(self : GeoprojstereographicEdge) -> Int { self.size }

pub fn GeoprojstereographicEdge::get(self : GeoprojstereographicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicEdge::set(self : GeoprojstereographicEdge, i : Int, v : Double) -> GeoprojstereographicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicEdge::sum(self : GeoprojstereographicEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicEdge::mean(self : GeoprojstereographicEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicEdge::scale(self : GeoprojstereographicEdge, f : Double) -> GeoprojstereographicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicEdge::add(self : GeoprojstereographicEdge, other : GeoprojstereographicEdge) -> GeoprojstereographicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicEdge::copy(self : GeoprojstereographicEdge) -> GeoprojstereographicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicEdge::fill(self : GeoprojstereographicEdge, v : Double) -> GeoprojstereographicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicEdge::min(self : GeoprojstereographicEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicEdge::max(self : GeoprojstereographicEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicEdge::to_string(self : GeoprojstereographicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_path_make(size : Int) -> GeoprojstereographicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicPath::len(self : GeoprojstereographicPath) -> Int { self.size }

pub fn GeoprojstereographicPath::get(self : GeoprojstereographicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicPath::set(self : GeoprojstereographicPath, i : Int, v : Double) -> GeoprojstereographicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicPath::sum(self : GeoprojstereographicPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicPath::mean(self : GeoprojstereographicPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicPath::scale(self : GeoprojstereographicPath, f : Double) -> GeoprojstereographicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicPath::add(self : GeoprojstereographicPath, other : GeoprojstereographicPath) -> GeoprojstereographicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicPath::copy(self : GeoprojstereographicPath) -> GeoprojstereographicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicPath::fill(self : GeoprojstereographicPath, v : Double) -> GeoprojstereographicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicPath::min(self : GeoprojstereographicPath) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicPath::max(self : GeoprojstereographicPath) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicPath::to_string(self : GeoprojstereographicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_cluster_make(size : Int) -> GeoprojstereographicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicCluster::len(self : GeoprojstereographicCluster) -> Int { self.size }

pub fn GeoprojstereographicCluster::get(self : GeoprojstereographicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicCluster::set(self : GeoprojstereographicCluster, i : Int, v : Double) -> GeoprojstereographicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCluster::sum(self : GeoprojstereographicCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicCluster::mean(self : GeoprojstereographicCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicCluster::scale(self : GeoprojstereographicCluster, f : Double) -> GeoprojstereographicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCluster::add(self : GeoprojstereographicCluster, other : GeoprojstereographicCluster) -> GeoprojstereographicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicCluster::copy(self : GeoprojstereographicCluster) -> GeoprojstereographicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCluster::fill(self : GeoprojstereographicCluster, v : Double) -> GeoprojstereographicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCluster::min(self : GeoprojstereographicCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicCluster::max(self : GeoprojstereographicCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicCluster::to_string(self : GeoprojstereographicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_model_make(size : Int) -> GeoprojstereographicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicModel::len(self : GeoprojstereographicModel) -> Int { self.size }

pub fn GeoprojstereographicModel::get(self : GeoprojstereographicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicModel::set(self : GeoprojstereographicModel, i : Int, v : Double) -> GeoprojstereographicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicModel::sum(self : GeoprojstereographicModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicModel::mean(self : GeoprojstereographicModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicModel::scale(self : GeoprojstereographicModel, f : Double) -> GeoprojstereographicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicModel::add(self : GeoprojstereographicModel, other : GeoprojstereographicModel) -> GeoprojstereographicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicModel::copy(self : GeoprojstereographicModel) -> GeoprojstereographicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicModel::fill(self : GeoprojstereographicModel, v : Double) -> GeoprojstereographicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicModel::min(self : GeoprojstereographicModel) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicModel::max(self : GeoprojstereographicModel) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicModel::to_string(self : GeoprojstereographicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_layer_make(size : Int) -> GeoprojstereographicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicLayer::len(self : GeoprojstereographicLayer) -> Int { self.size }

pub fn GeoprojstereographicLayer::get(self : GeoprojstereographicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicLayer::set(self : GeoprojstereographicLayer, i : Int, v : Double) -> GeoprojstereographicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicLayer::sum(self : GeoprojstereographicLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicLayer::mean(self : GeoprojstereographicLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicLayer::scale(self : GeoprojstereographicLayer, f : Double) -> GeoprojstereographicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicLayer::add(self : GeoprojstereographicLayer, other : GeoprojstereographicLayer) -> GeoprojstereographicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicLayer::copy(self : GeoprojstereographicLayer) -> GeoprojstereographicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicLayer::fill(self : GeoprojstereographicLayer, v : Double) -> GeoprojstereographicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicLayer::min(self : GeoprojstereographicLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicLayer::max(self : GeoprojstereographicLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicLayer::to_string(self : GeoprojstereographicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_buffer_make(size : Int) -> GeoprojstereographicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicBuffer::len(self : GeoprojstereographicBuffer) -> Int { self.size }

pub fn GeoprojstereographicBuffer::get(self : GeoprojstereographicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicBuffer::set(self : GeoprojstereographicBuffer, i : Int, v : Double) -> GeoprojstereographicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicBuffer::sum(self : GeoprojstereographicBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicBuffer::mean(self : GeoprojstereographicBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicBuffer::scale(self : GeoprojstereographicBuffer, f : Double) -> GeoprojstereographicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicBuffer::add(self : GeoprojstereographicBuffer, other : GeoprojstereographicBuffer) -> GeoprojstereographicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicBuffer::copy(self : GeoprojstereographicBuffer) -> GeoprojstereographicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicBuffer::fill(self : GeoprojstereographicBuffer, v : Double) -> GeoprojstereographicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicBuffer::min(self : GeoprojstereographicBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicBuffer::max(self : GeoprojstereographicBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicBuffer::to_string(self : GeoprojstereographicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_cursor_make(size : Int) -> GeoprojstereographicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicCursor::len(self : GeoprojstereographicCursor) -> Int { self.size }

pub fn GeoprojstereographicCursor::get(self : GeoprojstereographicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicCursor::set(self : GeoprojstereographicCursor, i : Int, v : Double) -> GeoprojstereographicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCursor::sum(self : GeoprojstereographicCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicCursor::mean(self : GeoprojstereographicCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicCursor::scale(self : GeoprojstereographicCursor, f : Double) -> GeoprojstereographicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCursor::add(self : GeoprojstereographicCursor, other : GeoprojstereographicCursor) -> GeoprojstereographicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicCursor::copy(self : GeoprojstereographicCursor) -> GeoprojstereographicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCursor::fill(self : GeoprojstereographicCursor, v : Double) -> GeoprojstereographicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicCursor::min(self : GeoprojstereographicCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicCursor::max(self : GeoprojstereographicCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicCursor::to_string(self : GeoprojstereographicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_view_make(size : Int) -> GeoprojstereographicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicView::len(self : GeoprojstereographicView) -> Int { self.size }

pub fn GeoprojstereographicView::get(self : GeoprojstereographicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicView::set(self : GeoprojstereographicView, i : Int, v : Double) -> GeoprojstereographicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicView::sum(self : GeoprojstereographicView) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicView::mean(self : GeoprojstereographicView) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicView::scale(self : GeoprojstereographicView, f : Double) -> GeoprojstereographicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicView::add(self : GeoprojstereographicView, other : GeoprojstereographicView) -> GeoprojstereographicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicView::copy(self : GeoprojstereographicView) -> GeoprojstereographicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicView::fill(self : GeoprojstereographicView, v : Double) -> GeoprojstereographicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicView::min(self : GeoprojstereographicView) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicView::max(self : GeoprojstereographicView) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicView::to_string(self : GeoprojstereographicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_range_make(size : Int) -> GeoprojstereographicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicRange::len(self : GeoprojstereographicRange) -> Int { self.size }

pub fn GeoprojstereographicRange::get(self : GeoprojstereographicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicRange::set(self : GeoprojstereographicRange, i : Int, v : Double) -> GeoprojstereographicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicRange::sum(self : GeoprojstereographicRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicRange::mean(self : GeoprojstereographicRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicRange::scale(self : GeoprojstereographicRange, f : Double) -> GeoprojstereographicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicRange::add(self : GeoprojstereographicRange, other : GeoprojstereographicRange) -> GeoprojstereographicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicRange::copy(self : GeoprojstereographicRange) -> GeoprojstereographicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicRange::fill(self : GeoprojstereographicRange, v : Double) -> GeoprojstereographicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicRange::min(self : GeoprojstereographicRange) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicRange::max(self : GeoprojstereographicRange) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicRange::to_string(self : GeoprojstereographicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_slice_make(size : Int) -> GeoprojstereographicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojstereographicSlice::len(self : GeoprojstereographicSlice) -> Int { self.size }

pub fn GeoprojstereographicSlice::get(self : GeoprojstereographicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojstereographicSlice::set(self : GeoprojstereographicSlice, i : Int, v : Double) -> GeoprojstereographicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicSlice::sum(self : GeoprojstereographicSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojstereographicSlice::mean(self : GeoprojstereographicSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojstereographicSlice::scale(self : GeoprojstereographicSlice, f : Double) -> GeoprojstereographicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicSlice::add(self : GeoprojstereographicSlice, other : GeoprojstereographicSlice) -> GeoprojstereographicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojstereographicSlice::copy(self : GeoprojstereographicSlice) -> GeoprojstereographicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicSlice::fill(self : GeoprojstereographicSlice, v : Double) -> GeoprojstereographicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojstereographicSlice::min(self : GeoprojstereographicSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojstereographicSlice::max(self : GeoprojstereographicSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojstereographicSlice::to_string(self : GeoprojstereographicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

