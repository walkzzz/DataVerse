///===
/// extcore/math_approx_wavelet

pub(all) struct MathapproxwaveletPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_wavelet_make_point(x : Double, y : Double) -> MathapproxwaveletPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_wavelet_make_point3(x : Double, y : Double, z : Double) -> MathapproxwaveletPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxwaveletPoint::x(self : MathapproxwaveletPoint) -> Double { self.x }

pub fn MathapproxwaveletPoint::y(self : MathapproxwaveletPoint) -> Double { self.y }

pub fn MathapproxwaveletPoint::z(self : MathapproxwaveletPoint) -> Double { self.z }

pub fn MathapproxwaveletPoint::label(self : MathapproxwaveletPoint) -> Int { self.label }

pub fn MathapproxwaveletPoint::dist(self : MathapproxwaveletPoint, other : MathapproxwaveletPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxwaveletPoint::add(self : MathapproxwaveletPoint, other : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxwaveletPoint::sub(self : MathapproxwaveletPoint, other : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxwaveletPoint::scale(self : MathapproxwaveletPoint, s : Double) -> MathapproxwaveletPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxwaveletPoint::dot(self : MathapproxwaveletPoint, other : MathapproxwaveletPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxwaveletPoint::cross(self : MathapproxwaveletPoint, other : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxwaveletPoint::norm(self : MathapproxwaveletPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxwaveletPoint::normalize(self : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxwaveletPoint::negate(self : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxwaveletPoint::mid(self : MathapproxwaveletPoint, other : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxwaveletPoint::lerp(self : MathapproxwaveletPoint, other : MathapproxwaveletPoint, t : Double) -> MathapproxwaveletPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxwaveletPoint::to_string(self : MathapproxwaveletPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxwaveletSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_wavelet_make_series(vals : Array[Double], name : String) -> MathapproxwaveletSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxwaveletSeries::len(self : MathapproxwaveletSeries) -> Int { self.vals.length() }

pub fn MathapproxwaveletSeries::sum(self : MathapproxwaveletSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxwaveletSeries::mean(self : MathapproxwaveletSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxwaveletSeries::min(self : MathapproxwaveletSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxwaveletSeries::max(self : MathapproxwaveletSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxwaveletSeries::range(self : MathapproxwaveletSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxwaveletSeries::variance(self : MathapproxwaveletSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxwaveletSeries::std(self : MathapproxwaveletSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxwaveletSeries::median(self : MathapproxwaveletSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxwaveletSeries::scale(self : MathapproxwaveletSeries, f : Double) -> MathapproxwaveletSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxwaveletSeries::add(self : MathapproxwaveletSeries, other : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxwaveletSeries::sub(self : MathapproxwaveletSeries, other : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxwaveletSeries::normalize(self : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxwaveletSeries::cumsum(self : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxwaveletSeries::to_string(self : MathapproxwaveletSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxwaveletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_wavelet_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxwaveletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_wavelet_matrix_identity(n : Int) -> MathapproxwaveletMatrix {
  let m = math_approx_wavelet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxwaveletMatrix::get(self : MathapproxwaveletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxwaveletMatrix::transpose(self : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  let result = math_approx_wavelet_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxwaveletMatrix::add(self : MathapproxwaveletMatrix, other : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_wavelet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxwaveletMatrix::scale(self : MathapproxwaveletMatrix, s : Double) -> MathapproxwaveletMatrix {
  let result = math_approx_wavelet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxwaveletMatrix::multiply(self : MathapproxwaveletMatrix, other : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  if self.cols != other.rows { return math_approx_wavelet_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_wavelet_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxwaveletMatrix::trace(self : MathapproxwaveletMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxwaveletMatrix::det(self : MathapproxwaveletMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxwaveletMatrix::norm(self : MathapproxwaveletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxwaveletMatrix::to_string(self : MathapproxwaveletMatrix) -> String {
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

pub(all) struct MathapproxwaveletVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_wavelet_make_vector(comps : Array[Double]) -> MathapproxwaveletVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_wavelet_vector_zero(dim : Int) -> MathapproxwaveletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxwaveletVector::add(self : MathapproxwaveletVector, other : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxwaveletVector::sub(self : MathapproxwaveletVector, other : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxwaveletVector::scale(self : MathapproxwaveletVector, s : Double) -> MathapproxwaveletVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxwaveletVector::dot(self : MathapproxwaveletVector, other : MathapproxwaveletVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxwaveletVector::norm(self : MathapproxwaveletVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxwaveletVector::normalize(self : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxwaveletVector::dist(self : MathapproxwaveletVector, other : MathapproxwaveletVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxwaveletVector::to_string(self : MathapproxwaveletVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxwaveletFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_frame_make(size : Int) -> MathapproxwaveletFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletFrame::len(self : MathapproxwaveletFrame) -> Int { self.size }

pub fn MathapproxwaveletFrame::get(self : MathapproxwaveletFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletFrame::set(self : MathapproxwaveletFrame, i : Int, v : Double) -> MathapproxwaveletFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletFrame::sum(self : MathapproxwaveletFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletFrame::mean(self : MathapproxwaveletFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletFrame::scale(self : MathapproxwaveletFrame, f : Double) -> MathapproxwaveletFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletFrame::add(self : MathapproxwaveletFrame, other : MathapproxwaveletFrame) -> MathapproxwaveletFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletFrame::copy(self : MathapproxwaveletFrame) -> MathapproxwaveletFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletFrame::fill(self : MathapproxwaveletFrame, v : Double) -> MathapproxwaveletFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletFrame::min(self : MathapproxwaveletFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletFrame::max(self : MathapproxwaveletFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletFrame::to_string(self : MathapproxwaveletFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_table_make(size : Int) -> MathapproxwaveletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletTable::len(self : MathapproxwaveletTable) -> Int { self.size }

pub fn MathapproxwaveletTable::get(self : MathapproxwaveletTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletTable::set(self : MathapproxwaveletTable, i : Int, v : Double) -> MathapproxwaveletTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletTable::sum(self : MathapproxwaveletTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletTable::mean(self : MathapproxwaveletTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletTable::scale(self : MathapproxwaveletTable, f : Double) -> MathapproxwaveletTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletTable::add(self : MathapproxwaveletTable, other : MathapproxwaveletTable) -> MathapproxwaveletTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletTable::copy(self : MathapproxwaveletTable) -> MathapproxwaveletTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletTable::fill(self : MathapproxwaveletTable, v : Double) -> MathapproxwaveletTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletTable::min(self : MathapproxwaveletTable) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletTable::max(self : MathapproxwaveletTable) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletTable::to_string(self : MathapproxwaveletTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_graphn_make(size : Int) -> MathapproxwaveletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletGraphN::len(self : MathapproxwaveletGraphN) -> Int { self.size }

pub fn MathapproxwaveletGraphN::get(self : MathapproxwaveletGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletGraphN::set(self : MathapproxwaveletGraphN, i : Int, v : Double) -> MathapproxwaveletGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletGraphN::sum(self : MathapproxwaveletGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletGraphN::mean(self : MathapproxwaveletGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletGraphN::scale(self : MathapproxwaveletGraphN, f : Double) -> MathapproxwaveletGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletGraphN::add(self : MathapproxwaveletGraphN, other : MathapproxwaveletGraphN) -> MathapproxwaveletGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletGraphN::copy(self : MathapproxwaveletGraphN) -> MathapproxwaveletGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletGraphN::fill(self : MathapproxwaveletGraphN, v : Double) -> MathapproxwaveletGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletGraphN::min(self : MathapproxwaveletGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletGraphN::max(self : MathapproxwaveletGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletGraphN::to_string(self : MathapproxwaveletGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_node_make(size : Int) -> MathapproxwaveletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletNode::len(self : MathapproxwaveletNode) -> Int { self.size }

pub fn MathapproxwaveletNode::get(self : MathapproxwaveletNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletNode::set(self : MathapproxwaveletNode, i : Int, v : Double) -> MathapproxwaveletNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletNode::sum(self : MathapproxwaveletNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletNode::mean(self : MathapproxwaveletNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletNode::scale(self : MathapproxwaveletNode, f : Double) -> MathapproxwaveletNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletNode::add(self : MathapproxwaveletNode, other : MathapproxwaveletNode) -> MathapproxwaveletNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletNode::copy(self : MathapproxwaveletNode) -> MathapproxwaveletNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletNode::fill(self : MathapproxwaveletNode, v : Double) -> MathapproxwaveletNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletNode::min(self : MathapproxwaveletNode) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletNode::max(self : MathapproxwaveletNode) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletNode::to_string(self : MathapproxwaveletNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_edge_make(size : Int) -> MathapproxwaveletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletEdge::len(self : MathapproxwaveletEdge) -> Int { self.size }

pub fn MathapproxwaveletEdge::get(self : MathapproxwaveletEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletEdge::set(self : MathapproxwaveletEdge, i : Int, v : Double) -> MathapproxwaveletEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletEdge::sum(self : MathapproxwaveletEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletEdge::mean(self : MathapproxwaveletEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletEdge::scale(self : MathapproxwaveletEdge, f : Double) -> MathapproxwaveletEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletEdge::add(self : MathapproxwaveletEdge, other : MathapproxwaveletEdge) -> MathapproxwaveletEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletEdge::copy(self : MathapproxwaveletEdge) -> MathapproxwaveletEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletEdge::fill(self : MathapproxwaveletEdge, v : Double) -> MathapproxwaveletEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletEdge::min(self : MathapproxwaveletEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletEdge::max(self : MathapproxwaveletEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletEdge::to_string(self : MathapproxwaveletEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_path_make(size : Int) -> MathapproxwaveletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletPath::len(self : MathapproxwaveletPath) -> Int { self.size }

pub fn MathapproxwaveletPath::get(self : MathapproxwaveletPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletPath::set(self : MathapproxwaveletPath, i : Int, v : Double) -> MathapproxwaveletPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletPath::sum(self : MathapproxwaveletPath) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletPath::mean(self : MathapproxwaveletPath) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletPath::scale(self : MathapproxwaveletPath, f : Double) -> MathapproxwaveletPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletPath::add(self : MathapproxwaveletPath, other : MathapproxwaveletPath) -> MathapproxwaveletPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletPath::copy(self : MathapproxwaveletPath) -> MathapproxwaveletPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletPath::fill(self : MathapproxwaveletPath, v : Double) -> MathapproxwaveletPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletPath::min(self : MathapproxwaveletPath) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletPath::max(self : MathapproxwaveletPath) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletPath::to_string(self : MathapproxwaveletPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_cluster_make(size : Int) -> MathapproxwaveletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletCluster::len(self : MathapproxwaveletCluster) -> Int { self.size }

pub fn MathapproxwaveletCluster::get(self : MathapproxwaveletCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletCluster::set(self : MathapproxwaveletCluster, i : Int, v : Double) -> MathapproxwaveletCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCluster::sum(self : MathapproxwaveletCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletCluster::mean(self : MathapproxwaveletCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletCluster::scale(self : MathapproxwaveletCluster, f : Double) -> MathapproxwaveletCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCluster::add(self : MathapproxwaveletCluster, other : MathapproxwaveletCluster) -> MathapproxwaveletCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletCluster::copy(self : MathapproxwaveletCluster) -> MathapproxwaveletCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCluster::fill(self : MathapproxwaveletCluster, v : Double) -> MathapproxwaveletCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCluster::min(self : MathapproxwaveletCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletCluster::max(self : MathapproxwaveletCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletCluster::to_string(self : MathapproxwaveletCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_model_make(size : Int) -> MathapproxwaveletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletModel::len(self : MathapproxwaveletModel) -> Int { self.size }

pub fn MathapproxwaveletModel::get(self : MathapproxwaveletModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletModel::set(self : MathapproxwaveletModel, i : Int, v : Double) -> MathapproxwaveletModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletModel::sum(self : MathapproxwaveletModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletModel::mean(self : MathapproxwaveletModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletModel::scale(self : MathapproxwaveletModel, f : Double) -> MathapproxwaveletModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletModel::add(self : MathapproxwaveletModel, other : MathapproxwaveletModel) -> MathapproxwaveletModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletModel::copy(self : MathapproxwaveletModel) -> MathapproxwaveletModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletModel::fill(self : MathapproxwaveletModel, v : Double) -> MathapproxwaveletModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletModel::min(self : MathapproxwaveletModel) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletModel::max(self : MathapproxwaveletModel) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletModel::to_string(self : MathapproxwaveletModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_layer_make(size : Int) -> MathapproxwaveletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletLayer::len(self : MathapproxwaveletLayer) -> Int { self.size }

pub fn MathapproxwaveletLayer::get(self : MathapproxwaveletLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletLayer::set(self : MathapproxwaveletLayer, i : Int, v : Double) -> MathapproxwaveletLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletLayer::sum(self : MathapproxwaveletLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletLayer::mean(self : MathapproxwaveletLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletLayer::scale(self : MathapproxwaveletLayer, f : Double) -> MathapproxwaveletLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletLayer::add(self : MathapproxwaveletLayer, other : MathapproxwaveletLayer) -> MathapproxwaveletLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletLayer::copy(self : MathapproxwaveletLayer) -> MathapproxwaveletLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletLayer::fill(self : MathapproxwaveletLayer, v : Double) -> MathapproxwaveletLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletLayer::min(self : MathapproxwaveletLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletLayer::max(self : MathapproxwaveletLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletLayer::to_string(self : MathapproxwaveletLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_buffer_make(size : Int) -> MathapproxwaveletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletBuffer::len(self : MathapproxwaveletBuffer) -> Int { self.size }

pub fn MathapproxwaveletBuffer::get(self : MathapproxwaveletBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletBuffer::set(self : MathapproxwaveletBuffer, i : Int, v : Double) -> MathapproxwaveletBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletBuffer::sum(self : MathapproxwaveletBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletBuffer::mean(self : MathapproxwaveletBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletBuffer::scale(self : MathapproxwaveletBuffer, f : Double) -> MathapproxwaveletBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletBuffer::add(self : MathapproxwaveletBuffer, other : MathapproxwaveletBuffer) -> MathapproxwaveletBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletBuffer::copy(self : MathapproxwaveletBuffer) -> MathapproxwaveletBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletBuffer::fill(self : MathapproxwaveletBuffer, v : Double) -> MathapproxwaveletBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletBuffer::min(self : MathapproxwaveletBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletBuffer::max(self : MathapproxwaveletBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletBuffer::to_string(self : MathapproxwaveletBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_cursor_make(size : Int) -> MathapproxwaveletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletCursor::len(self : MathapproxwaveletCursor) -> Int { self.size }

pub fn MathapproxwaveletCursor::get(self : MathapproxwaveletCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletCursor::set(self : MathapproxwaveletCursor, i : Int, v : Double) -> MathapproxwaveletCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCursor::sum(self : MathapproxwaveletCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletCursor::mean(self : MathapproxwaveletCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletCursor::scale(self : MathapproxwaveletCursor, f : Double) -> MathapproxwaveletCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCursor::add(self : MathapproxwaveletCursor, other : MathapproxwaveletCursor) -> MathapproxwaveletCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletCursor::copy(self : MathapproxwaveletCursor) -> MathapproxwaveletCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCursor::fill(self : MathapproxwaveletCursor, v : Double) -> MathapproxwaveletCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletCursor::min(self : MathapproxwaveletCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletCursor::max(self : MathapproxwaveletCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletCursor::to_string(self : MathapproxwaveletCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_view_make(size : Int) -> MathapproxwaveletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletView::len(self : MathapproxwaveletView) -> Int { self.size }

pub fn MathapproxwaveletView::get(self : MathapproxwaveletView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletView::set(self : MathapproxwaveletView, i : Int, v : Double) -> MathapproxwaveletView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletView::sum(self : MathapproxwaveletView) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletView::mean(self : MathapproxwaveletView) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletView::scale(self : MathapproxwaveletView, f : Double) -> MathapproxwaveletView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletView::add(self : MathapproxwaveletView, other : MathapproxwaveletView) -> MathapproxwaveletView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletView::copy(self : MathapproxwaveletView) -> MathapproxwaveletView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletView::fill(self : MathapproxwaveletView, v : Double) -> MathapproxwaveletView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletView::min(self : MathapproxwaveletView) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletView::max(self : MathapproxwaveletView) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletView::to_string(self : MathapproxwaveletView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_range_make(size : Int) -> MathapproxwaveletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletRange::len(self : MathapproxwaveletRange) -> Int { self.size }

pub fn MathapproxwaveletRange::get(self : MathapproxwaveletRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletRange::set(self : MathapproxwaveletRange, i : Int, v : Double) -> MathapproxwaveletRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletRange::sum(self : MathapproxwaveletRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletRange::mean(self : MathapproxwaveletRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletRange::scale(self : MathapproxwaveletRange, f : Double) -> MathapproxwaveletRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletRange::add(self : MathapproxwaveletRange, other : MathapproxwaveletRange) -> MathapproxwaveletRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletRange::copy(self : MathapproxwaveletRange) -> MathapproxwaveletRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletRange::fill(self : MathapproxwaveletRange, v : Double) -> MathapproxwaveletRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletRange::min(self : MathapproxwaveletRange) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletRange::max(self : MathapproxwaveletRange) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletRange::to_string(self : MathapproxwaveletRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_slice_make(size : Int) -> MathapproxwaveletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxwaveletSlice::len(self : MathapproxwaveletSlice) -> Int { self.size }

pub fn MathapproxwaveletSlice::get(self : MathapproxwaveletSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxwaveletSlice::set(self : MathapproxwaveletSlice, i : Int, v : Double) -> MathapproxwaveletSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletSlice::sum(self : MathapproxwaveletSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxwaveletSlice::mean(self : MathapproxwaveletSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxwaveletSlice::scale(self : MathapproxwaveletSlice, f : Double) -> MathapproxwaveletSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletSlice::add(self : MathapproxwaveletSlice, other : MathapproxwaveletSlice) -> MathapproxwaveletSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxwaveletSlice::copy(self : MathapproxwaveletSlice) -> MathapproxwaveletSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletSlice::fill(self : MathapproxwaveletSlice, v : Double) -> MathapproxwaveletSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxwaveletSlice::min(self : MathapproxwaveletSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxwaveletSlice::max(self : MathapproxwaveletSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxwaveletSlice::to_string(self : MathapproxwaveletSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

