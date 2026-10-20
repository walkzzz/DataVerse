///===
/// extcore/math_approx_fourier

pub(all) struct MathapproxfourierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_fourier_make_point(x : Double, y : Double) -> MathapproxfourierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_fourier_make_point3(x : Double, y : Double, z : Double) -> MathapproxfourierPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxfourierPoint::x(self : MathapproxfourierPoint) -> Double { self.x }

pub fn MathapproxfourierPoint::y(self : MathapproxfourierPoint) -> Double { self.y }

pub fn MathapproxfourierPoint::z(self : MathapproxfourierPoint) -> Double { self.z }

pub fn MathapproxfourierPoint::label(self : MathapproxfourierPoint) -> Int { self.label }

pub fn MathapproxfourierPoint::dist(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxfourierPoint::add(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxfourierPoint::sub(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxfourierPoint::scale(self : MathapproxfourierPoint, s : Double) -> MathapproxfourierPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxfourierPoint::dot(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxfourierPoint::cross(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxfourierPoint::norm(self : MathapproxfourierPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxfourierPoint::normalize(self : MathapproxfourierPoint) -> MathapproxfourierPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxfourierPoint::negate(self : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxfourierPoint::mid(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxfourierPoint::lerp(self : MathapproxfourierPoint, other : MathapproxfourierPoint, t : Double) -> MathapproxfourierPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxfourierPoint::to_string(self : MathapproxfourierPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxfourierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_fourier_make_series(vals : Array[Double], name : String) -> MathapproxfourierSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxfourierSeries::len(self : MathapproxfourierSeries) -> Int { self.vals.length() }

pub fn MathapproxfourierSeries::sum(self : MathapproxfourierSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxfourierSeries::mean(self : MathapproxfourierSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxfourierSeries::min(self : MathapproxfourierSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxfourierSeries::max(self : MathapproxfourierSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxfourierSeries::range(self : MathapproxfourierSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxfourierSeries::variance(self : MathapproxfourierSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxfourierSeries::std(self : MathapproxfourierSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxfourierSeries::median(self : MathapproxfourierSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxfourierSeries::scale(self : MathapproxfourierSeries, f : Double) -> MathapproxfourierSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxfourierSeries::add(self : MathapproxfourierSeries, other : MathapproxfourierSeries) -> MathapproxfourierSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxfourierSeries::sub(self : MathapproxfourierSeries, other : MathapproxfourierSeries) -> MathapproxfourierSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxfourierSeries::normalize(self : MathapproxfourierSeries) -> MathapproxfourierSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxfourierSeries::cumsum(self : MathapproxfourierSeries) -> MathapproxfourierSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxfourierSeries::to_string(self : MathapproxfourierSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxfourierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_fourier_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxfourierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_fourier_matrix_identity(n : Int) -> MathapproxfourierMatrix {
  let m = math_approx_fourier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxfourierMatrix::get(self : MathapproxfourierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxfourierMatrix::transpose(self : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  let result = math_approx_fourier_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxfourierMatrix::add(self : MathapproxfourierMatrix, other : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_fourier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxfourierMatrix::scale(self : MathapproxfourierMatrix, s : Double) -> MathapproxfourierMatrix {
  let result = math_approx_fourier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxfourierMatrix::multiply(self : MathapproxfourierMatrix, other : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  if self.cols != other.rows { return math_approx_fourier_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_fourier_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxfourierMatrix::trace(self : MathapproxfourierMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxfourierMatrix::det(self : MathapproxfourierMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxfourierMatrix::norm(self : MathapproxfourierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxfourierMatrix::to_string(self : MathapproxfourierMatrix) -> String {
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

pub(all) struct MathapproxfourierVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_fourier_make_vector(comps : Array[Double]) -> MathapproxfourierVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_fourier_vector_zero(dim : Int) -> MathapproxfourierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxfourierVector::add(self : MathapproxfourierVector, other : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxfourierVector::sub(self : MathapproxfourierVector, other : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxfourierVector::scale(self : MathapproxfourierVector, s : Double) -> MathapproxfourierVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxfourierVector::dot(self : MathapproxfourierVector, other : MathapproxfourierVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxfourierVector::norm(self : MathapproxfourierVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxfourierVector::normalize(self : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxfourierVector::dist(self : MathapproxfourierVector, other : MathapproxfourierVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxfourierVector::to_string(self : MathapproxfourierVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxfourierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_frame_make(size : Int) -> MathapproxfourierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierFrame::len(self : MathapproxfourierFrame) -> Int { self.size }

pub fn MathapproxfourierFrame::get(self : MathapproxfourierFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierFrame::set(self : MathapproxfourierFrame, i : Int, v : Double) -> MathapproxfourierFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierFrame::sum(self : MathapproxfourierFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierFrame::mean(self : MathapproxfourierFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierFrame::scale(self : MathapproxfourierFrame, f : Double) -> MathapproxfourierFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierFrame::add(self : MathapproxfourierFrame, other : MathapproxfourierFrame) -> MathapproxfourierFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierFrame::copy(self : MathapproxfourierFrame) -> MathapproxfourierFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierFrame::fill(self : MathapproxfourierFrame, v : Double) -> MathapproxfourierFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierFrame::min(self : MathapproxfourierFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierFrame::max(self : MathapproxfourierFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierFrame::to_string(self : MathapproxfourierFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_table_make(size : Int) -> MathapproxfourierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierTable::len(self : MathapproxfourierTable) -> Int { self.size }

pub fn MathapproxfourierTable::get(self : MathapproxfourierTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierTable::set(self : MathapproxfourierTable, i : Int, v : Double) -> MathapproxfourierTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierTable::sum(self : MathapproxfourierTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierTable::mean(self : MathapproxfourierTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierTable::scale(self : MathapproxfourierTable, f : Double) -> MathapproxfourierTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierTable::add(self : MathapproxfourierTable, other : MathapproxfourierTable) -> MathapproxfourierTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierTable::copy(self : MathapproxfourierTable) -> MathapproxfourierTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierTable::fill(self : MathapproxfourierTable, v : Double) -> MathapproxfourierTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierTable::min(self : MathapproxfourierTable) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierTable::max(self : MathapproxfourierTable) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierTable::to_string(self : MathapproxfourierTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_graphn_make(size : Int) -> MathapproxfourierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierGraphN::len(self : MathapproxfourierGraphN) -> Int { self.size }

pub fn MathapproxfourierGraphN::get(self : MathapproxfourierGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierGraphN::set(self : MathapproxfourierGraphN, i : Int, v : Double) -> MathapproxfourierGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierGraphN::sum(self : MathapproxfourierGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierGraphN::mean(self : MathapproxfourierGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierGraphN::scale(self : MathapproxfourierGraphN, f : Double) -> MathapproxfourierGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierGraphN::add(self : MathapproxfourierGraphN, other : MathapproxfourierGraphN) -> MathapproxfourierGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierGraphN::copy(self : MathapproxfourierGraphN) -> MathapproxfourierGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierGraphN::fill(self : MathapproxfourierGraphN, v : Double) -> MathapproxfourierGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierGraphN::min(self : MathapproxfourierGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierGraphN::max(self : MathapproxfourierGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierGraphN::to_string(self : MathapproxfourierGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_node_make(size : Int) -> MathapproxfourierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierNode::len(self : MathapproxfourierNode) -> Int { self.size }

pub fn MathapproxfourierNode::get(self : MathapproxfourierNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierNode::set(self : MathapproxfourierNode, i : Int, v : Double) -> MathapproxfourierNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierNode::sum(self : MathapproxfourierNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierNode::mean(self : MathapproxfourierNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierNode::scale(self : MathapproxfourierNode, f : Double) -> MathapproxfourierNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierNode::add(self : MathapproxfourierNode, other : MathapproxfourierNode) -> MathapproxfourierNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierNode::copy(self : MathapproxfourierNode) -> MathapproxfourierNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierNode::fill(self : MathapproxfourierNode, v : Double) -> MathapproxfourierNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierNode::min(self : MathapproxfourierNode) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierNode::max(self : MathapproxfourierNode) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierNode::to_string(self : MathapproxfourierNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_edge_make(size : Int) -> MathapproxfourierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierEdge::len(self : MathapproxfourierEdge) -> Int { self.size }

pub fn MathapproxfourierEdge::get(self : MathapproxfourierEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierEdge::set(self : MathapproxfourierEdge, i : Int, v : Double) -> MathapproxfourierEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierEdge::sum(self : MathapproxfourierEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierEdge::mean(self : MathapproxfourierEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierEdge::scale(self : MathapproxfourierEdge, f : Double) -> MathapproxfourierEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierEdge::add(self : MathapproxfourierEdge, other : MathapproxfourierEdge) -> MathapproxfourierEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierEdge::copy(self : MathapproxfourierEdge) -> MathapproxfourierEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierEdge::fill(self : MathapproxfourierEdge, v : Double) -> MathapproxfourierEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierEdge::min(self : MathapproxfourierEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierEdge::max(self : MathapproxfourierEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierEdge::to_string(self : MathapproxfourierEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_path_make(size : Int) -> MathapproxfourierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierPath::len(self : MathapproxfourierPath) -> Int { self.size }

pub fn MathapproxfourierPath::get(self : MathapproxfourierPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierPath::set(self : MathapproxfourierPath, i : Int, v : Double) -> MathapproxfourierPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierPath::sum(self : MathapproxfourierPath) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierPath::mean(self : MathapproxfourierPath) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierPath::scale(self : MathapproxfourierPath, f : Double) -> MathapproxfourierPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierPath::add(self : MathapproxfourierPath, other : MathapproxfourierPath) -> MathapproxfourierPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierPath::copy(self : MathapproxfourierPath) -> MathapproxfourierPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierPath::fill(self : MathapproxfourierPath, v : Double) -> MathapproxfourierPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierPath::min(self : MathapproxfourierPath) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierPath::max(self : MathapproxfourierPath) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierPath::to_string(self : MathapproxfourierPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_cluster_make(size : Int) -> MathapproxfourierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierCluster::len(self : MathapproxfourierCluster) -> Int { self.size }

pub fn MathapproxfourierCluster::get(self : MathapproxfourierCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierCluster::set(self : MathapproxfourierCluster, i : Int, v : Double) -> MathapproxfourierCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCluster::sum(self : MathapproxfourierCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierCluster::mean(self : MathapproxfourierCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierCluster::scale(self : MathapproxfourierCluster, f : Double) -> MathapproxfourierCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCluster::add(self : MathapproxfourierCluster, other : MathapproxfourierCluster) -> MathapproxfourierCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierCluster::copy(self : MathapproxfourierCluster) -> MathapproxfourierCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCluster::fill(self : MathapproxfourierCluster, v : Double) -> MathapproxfourierCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCluster::min(self : MathapproxfourierCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierCluster::max(self : MathapproxfourierCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierCluster::to_string(self : MathapproxfourierCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_model_make(size : Int) -> MathapproxfourierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierModel::len(self : MathapproxfourierModel) -> Int { self.size }

pub fn MathapproxfourierModel::get(self : MathapproxfourierModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierModel::set(self : MathapproxfourierModel, i : Int, v : Double) -> MathapproxfourierModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierModel::sum(self : MathapproxfourierModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierModel::mean(self : MathapproxfourierModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierModel::scale(self : MathapproxfourierModel, f : Double) -> MathapproxfourierModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierModel::add(self : MathapproxfourierModel, other : MathapproxfourierModel) -> MathapproxfourierModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierModel::copy(self : MathapproxfourierModel) -> MathapproxfourierModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierModel::fill(self : MathapproxfourierModel, v : Double) -> MathapproxfourierModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierModel::min(self : MathapproxfourierModel) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierModel::max(self : MathapproxfourierModel) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierModel::to_string(self : MathapproxfourierModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_layer_make(size : Int) -> MathapproxfourierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierLayer::len(self : MathapproxfourierLayer) -> Int { self.size }

pub fn MathapproxfourierLayer::get(self : MathapproxfourierLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierLayer::set(self : MathapproxfourierLayer, i : Int, v : Double) -> MathapproxfourierLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierLayer::sum(self : MathapproxfourierLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierLayer::mean(self : MathapproxfourierLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierLayer::scale(self : MathapproxfourierLayer, f : Double) -> MathapproxfourierLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierLayer::add(self : MathapproxfourierLayer, other : MathapproxfourierLayer) -> MathapproxfourierLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierLayer::copy(self : MathapproxfourierLayer) -> MathapproxfourierLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierLayer::fill(self : MathapproxfourierLayer, v : Double) -> MathapproxfourierLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierLayer::min(self : MathapproxfourierLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierLayer::max(self : MathapproxfourierLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierLayer::to_string(self : MathapproxfourierLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_buffer_make(size : Int) -> MathapproxfourierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierBuffer::len(self : MathapproxfourierBuffer) -> Int { self.size }

pub fn MathapproxfourierBuffer::get(self : MathapproxfourierBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierBuffer::set(self : MathapproxfourierBuffer, i : Int, v : Double) -> MathapproxfourierBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierBuffer::sum(self : MathapproxfourierBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierBuffer::mean(self : MathapproxfourierBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierBuffer::scale(self : MathapproxfourierBuffer, f : Double) -> MathapproxfourierBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierBuffer::add(self : MathapproxfourierBuffer, other : MathapproxfourierBuffer) -> MathapproxfourierBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierBuffer::copy(self : MathapproxfourierBuffer) -> MathapproxfourierBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierBuffer::fill(self : MathapproxfourierBuffer, v : Double) -> MathapproxfourierBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierBuffer::min(self : MathapproxfourierBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierBuffer::max(self : MathapproxfourierBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierBuffer::to_string(self : MathapproxfourierBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_cursor_make(size : Int) -> MathapproxfourierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierCursor::len(self : MathapproxfourierCursor) -> Int { self.size }

pub fn MathapproxfourierCursor::get(self : MathapproxfourierCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierCursor::set(self : MathapproxfourierCursor, i : Int, v : Double) -> MathapproxfourierCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCursor::sum(self : MathapproxfourierCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierCursor::mean(self : MathapproxfourierCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierCursor::scale(self : MathapproxfourierCursor, f : Double) -> MathapproxfourierCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCursor::add(self : MathapproxfourierCursor, other : MathapproxfourierCursor) -> MathapproxfourierCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierCursor::copy(self : MathapproxfourierCursor) -> MathapproxfourierCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCursor::fill(self : MathapproxfourierCursor, v : Double) -> MathapproxfourierCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierCursor::min(self : MathapproxfourierCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierCursor::max(self : MathapproxfourierCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierCursor::to_string(self : MathapproxfourierCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_view_make(size : Int) -> MathapproxfourierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierView::len(self : MathapproxfourierView) -> Int { self.size }

pub fn MathapproxfourierView::get(self : MathapproxfourierView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierView::set(self : MathapproxfourierView, i : Int, v : Double) -> MathapproxfourierView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierView::sum(self : MathapproxfourierView) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierView::mean(self : MathapproxfourierView) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierView::scale(self : MathapproxfourierView, f : Double) -> MathapproxfourierView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierView::add(self : MathapproxfourierView, other : MathapproxfourierView) -> MathapproxfourierView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierView::copy(self : MathapproxfourierView) -> MathapproxfourierView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierView::fill(self : MathapproxfourierView, v : Double) -> MathapproxfourierView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierView::min(self : MathapproxfourierView) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierView::max(self : MathapproxfourierView) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierView::to_string(self : MathapproxfourierView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_range_make(size : Int) -> MathapproxfourierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierRange::len(self : MathapproxfourierRange) -> Int { self.size }

pub fn MathapproxfourierRange::get(self : MathapproxfourierRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierRange::set(self : MathapproxfourierRange, i : Int, v : Double) -> MathapproxfourierRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierRange::sum(self : MathapproxfourierRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierRange::mean(self : MathapproxfourierRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierRange::scale(self : MathapproxfourierRange, f : Double) -> MathapproxfourierRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierRange::add(self : MathapproxfourierRange, other : MathapproxfourierRange) -> MathapproxfourierRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierRange::copy(self : MathapproxfourierRange) -> MathapproxfourierRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierRange::fill(self : MathapproxfourierRange, v : Double) -> MathapproxfourierRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierRange::min(self : MathapproxfourierRange) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierRange::max(self : MathapproxfourierRange) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierRange::to_string(self : MathapproxfourierRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_slice_make(size : Int) -> MathapproxfourierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxfourierSlice::len(self : MathapproxfourierSlice) -> Int { self.size }

pub fn MathapproxfourierSlice::get(self : MathapproxfourierSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxfourierSlice::set(self : MathapproxfourierSlice, i : Int, v : Double) -> MathapproxfourierSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxfourierSlice::sum(self : MathapproxfourierSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxfourierSlice::mean(self : MathapproxfourierSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxfourierSlice::scale(self : MathapproxfourierSlice, f : Double) -> MathapproxfourierSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierSlice::add(self : MathapproxfourierSlice, other : MathapproxfourierSlice) -> MathapproxfourierSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxfourierSlice::copy(self : MathapproxfourierSlice) -> MathapproxfourierSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierSlice::fill(self : MathapproxfourierSlice, v : Double) -> MathapproxfourierSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxfourierSlice::min(self : MathapproxfourierSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxfourierSlice::max(self : MathapproxfourierSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxfourierSlice::to_string(self : MathapproxfourierSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

