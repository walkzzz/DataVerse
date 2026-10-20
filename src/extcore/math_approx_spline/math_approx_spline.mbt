///===
/// extcore/math_approx_spline

pub(all) struct MathapproxsplinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_spline_make_point(x : Double, y : Double) -> MathapproxsplinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_spline_make_point3(x : Double, y : Double, z : Double) -> MathapproxsplinePoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxsplinePoint::x(self : MathapproxsplinePoint) -> Double { self.x }

pub fn MathapproxsplinePoint::y(self : MathapproxsplinePoint) -> Double { self.y }

pub fn MathapproxsplinePoint::z(self : MathapproxsplinePoint) -> Double { self.z }

pub fn MathapproxsplinePoint::label(self : MathapproxsplinePoint) -> Int { self.label }

pub fn MathapproxsplinePoint::dist(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxsplinePoint::add(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxsplinePoint::sub(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxsplinePoint::scale(self : MathapproxsplinePoint, s : Double) -> MathapproxsplinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxsplinePoint::dot(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxsplinePoint::cross(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxsplinePoint::norm(self : MathapproxsplinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxsplinePoint::normalize(self : MathapproxsplinePoint) -> MathapproxsplinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxsplinePoint::negate(self : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxsplinePoint::mid(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxsplinePoint::lerp(self : MathapproxsplinePoint, other : MathapproxsplinePoint, t : Double) -> MathapproxsplinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxsplinePoint::to_string(self : MathapproxsplinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxsplineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_spline_make_series(vals : Array[Double], name : String) -> MathapproxsplineSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxsplineSeries::len(self : MathapproxsplineSeries) -> Int { self.vals.length() }

pub fn MathapproxsplineSeries::sum(self : MathapproxsplineSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxsplineSeries::mean(self : MathapproxsplineSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxsplineSeries::min(self : MathapproxsplineSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxsplineSeries::max(self : MathapproxsplineSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxsplineSeries::range(self : MathapproxsplineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxsplineSeries::variance(self : MathapproxsplineSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxsplineSeries::std(self : MathapproxsplineSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxsplineSeries::median(self : MathapproxsplineSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxsplineSeries::scale(self : MathapproxsplineSeries, f : Double) -> MathapproxsplineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxsplineSeries::add(self : MathapproxsplineSeries, other : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxsplineSeries::sub(self : MathapproxsplineSeries, other : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxsplineSeries::normalize(self : MathapproxsplineSeries) -> MathapproxsplineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxsplineSeries::cumsum(self : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxsplineSeries::to_string(self : MathapproxsplineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxsplineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_spline_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxsplineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_spline_matrix_identity(n : Int) -> MathapproxsplineMatrix {
  let m = math_approx_spline_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxsplineMatrix::get(self : MathapproxsplineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxsplineMatrix::transpose(self : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxsplineMatrix::add(self : MathapproxsplineMatrix, other : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_spline_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxsplineMatrix::scale(self : MathapproxsplineMatrix, s : Double) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxsplineMatrix::multiply(self : MathapproxsplineMatrix, other : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if self.cols != other.rows { return math_approx_spline_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_spline_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathapproxsplineMatrix::trace(self : MathapproxsplineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxsplineMatrix::det(self : MathapproxsplineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxsplineMatrix::norm(self : MathapproxsplineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxsplineMatrix::to_string(self : MathapproxsplineMatrix) -> String {
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

pub(all) struct MathapproxsplineVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_spline_make_vector(comps : Array[Double]) -> MathapproxsplineVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_spline_vector_zero(dim : Int) -> MathapproxsplineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxsplineVector::add(self : MathapproxsplineVector, other : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxsplineVector::sub(self : MathapproxsplineVector, other : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxsplineVector::scale(self : MathapproxsplineVector, s : Double) -> MathapproxsplineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxsplineVector::dot(self : MathapproxsplineVector, other : MathapproxsplineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxsplineVector::norm(self : MathapproxsplineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxsplineVector::normalize(self : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxsplineVector::dist(self : MathapproxsplineVector, other : MathapproxsplineVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxsplineVector::to_string(self : MathapproxsplineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxsplineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_frame_make(size : Int) -> MathapproxsplineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineFrame::len(self : MathapproxsplineFrame) -> Int { self.size }

pub fn MathapproxsplineFrame::get(self : MathapproxsplineFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineFrame::set(self : MathapproxsplineFrame, i : Int, v : Double) -> MathapproxsplineFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineFrame::sum(self : MathapproxsplineFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineFrame::mean(self : MathapproxsplineFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineFrame::scale(self : MathapproxsplineFrame, f : Double) -> MathapproxsplineFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineFrame::add(self : MathapproxsplineFrame, other : MathapproxsplineFrame) -> MathapproxsplineFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineFrame::copy(self : MathapproxsplineFrame) -> MathapproxsplineFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineFrame::fill(self : MathapproxsplineFrame, v : Double) -> MathapproxsplineFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineFrame::min(self : MathapproxsplineFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineFrame::max(self : MathapproxsplineFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineFrame::to_string(self : MathapproxsplineFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_table_make(size : Int) -> MathapproxsplineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineTable::len(self : MathapproxsplineTable) -> Int { self.size }

pub fn MathapproxsplineTable::get(self : MathapproxsplineTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineTable::set(self : MathapproxsplineTable, i : Int, v : Double) -> MathapproxsplineTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineTable::sum(self : MathapproxsplineTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineTable::mean(self : MathapproxsplineTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineTable::scale(self : MathapproxsplineTable, f : Double) -> MathapproxsplineTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineTable::add(self : MathapproxsplineTable, other : MathapproxsplineTable) -> MathapproxsplineTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineTable::copy(self : MathapproxsplineTable) -> MathapproxsplineTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineTable::fill(self : MathapproxsplineTable, v : Double) -> MathapproxsplineTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineTable::min(self : MathapproxsplineTable) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineTable::max(self : MathapproxsplineTable) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineTable::to_string(self : MathapproxsplineTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_graphn_make(size : Int) -> MathapproxsplineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineGraphN::len(self : MathapproxsplineGraphN) -> Int { self.size }

pub fn MathapproxsplineGraphN::get(self : MathapproxsplineGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineGraphN::set(self : MathapproxsplineGraphN, i : Int, v : Double) -> MathapproxsplineGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineGraphN::sum(self : MathapproxsplineGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineGraphN::mean(self : MathapproxsplineGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineGraphN::scale(self : MathapproxsplineGraphN, f : Double) -> MathapproxsplineGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineGraphN::add(self : MathapproxsplineGraphN, other : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineGraphN::copy(self : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineGraphN::fill(self : MathapproxsplineGraphN, v : Double) -> MathapproxsplineGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineGraphN::min(self : MathapproxsplineGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineGraphN::max(self : MathapproxsplineGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineGraphN::to_string(self : MathapproxsplineGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_node_make(size : Int) -> MathapproxsplineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineNode::len(self : MathapproxsplineNode) -> Int { self.size }

pub fn MathapproxsplineNode::get(self : MathapproxsplineNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineNode::set(self : MathapproxsplineNode, i : Int, v : Double) -> MathapproxsplineNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineNode::sum(self : MathapproxsplineNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineNode::mean(self : MathapproxsplineNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineNode::scale(self : MathapproxsplineNode, f : Double) -> MathapproxsplineNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineNode::add(self : MathapproxsplineNode, other : MathapproxsplineNode) -> MathapproxsplineNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineNode::copy(self : MathapproxsplineNode) -> MathapproxsplineNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineNode::fill(self : MathapproxsplineNode, v : Double) -> MathapproxsplineNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineNode::min(self : MathapproxsplineNode) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineNode::max(self : MathapproxsplineNode) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineNode::to_string(self : MathapproxsplineNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_edge_make(size : Int) -> MathapproxsplineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineEdge::len(self : MathapproxsplineEdge) -> Int { self.size }

pub fn MathapproxsplineEdge::get(self : MathapproxsplineEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineEdge::set(self : MathapproxsplineEdge, i : Int, v : Double) -> MathapproxsplineEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineEdge::sum(self : MathapproxsplineEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineEdge::mean(self : MathapproxsplineEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineEdge::scale(self : MathapproxsplineEdge, f : Double) -> MathapproxsplineEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineEdge::add(self : MathapproxsplineEdge, other : MathapproxsplineEdge) -> MathapproxsplineEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineEdge::copy(self : MathapproxsplineEdge) -> MathapproxsplineEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineEdge::fill(self : MathapproxsplineEdge, v : Double) -> MathapproxsplineEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineEdge::min(self : MathapproxsplineEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineEdge::max(self : MathapproxsplineEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineEdge::to_string(self : MathapproxsplineEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_path_make(size : Int) -> MathapproxsplinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplinePath::len(self : MathapproxsplinePath) -> Int { self.size }

pub fn MathapproxsplinePath::get(self : MathapproxsplinePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplinePath::set(self : MathapproxsplinePath, i : Int, v : Double) -> MathapproxsplinePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplinePath::sum(self : MathapproxsplinePath) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplinePath::mean(self : MathapproxsplinePath) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplinePath::scale(self : MathapproxsplinePath, f : Double) -> MathapproxsplinePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplinePath::add(self : MathapproxsplinePath, other : MathapproxsplinePath) -> MathapproxsplinePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplinePath::copy(self : MathapproxsplinePath) -> MathapproxsplinePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplinePath::fill(self : MathapproxsplinePath, v : Double) -> MathapproxsplinePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplinePath::min(self : MathapproxsplinePath) -> Double { @_common.min(self.data) }

pub fn MathapproxsplinePath::max(self : MathapproxsplinePath) -> Double { @_common.max(self.data) }

pub fn MathapproxsplinePath::to_string(self : MathapproxsplinePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cluster_make(size : Int) -> MathapproxsplineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineCluster::len(self : MathapproxsplineCluster) -> Int { self.size }

pub fn MathapproxsplineCluster::get(self : MathapproxsplineCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineCluster::set(self : MathapproxsplineCluster, i : Int, v : Double) -> MathapproxsplineCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCluster::sum(self : MathapproxsplineCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineCluster::mean(self : MathapproxsplineCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineCluster::scale(self : MathapproxsplineCluster, f : Double) -> MathapproxsplineCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCluster::add(self : MathapproxsplineCluster, other : MathapproxsplineCluster) -> MathapproxsplineCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineCluster::copy(self : MathapproxsplineCluster) -> MathapproxsplineCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCluster::fill(self : MathapproxsplineCluster, v : Double) -> MathapproxsplineCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCluster::min(self : MathapproxsplineCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineCluster::max(self : MathapproxsplineCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineCluster::to_string(self : MathapproxsplineCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_model_make(size : Int) -> MathapproxsplineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineModel::len(self : MathapproxsplineModel) -> Int { self.size }

pub fn MathapproxsplineModel::get(self : MathapproxsplineModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineModel::set(self : MathapproxsplineModel, i : Int, v : Double) -> MathapproxsplineModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineModel::sum(self : MathapproxsplineModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineModel::mean(self : MathapproxsplineModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineModel::scale(self : MathapproxsplineModel, f : Double) -> MathapproxsplineModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineModel::add(self : MathapproxsplineModel, other : MathapproxsplineModel) -> MathapproxsplineModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineModel::copy(self : MathapproxsplineModel) -> MathapproxsplineModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineModel::fill(self : MathapproxsplineModel, v : Double) -> MathapproxsplineModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineModel::min(self : MathapproxsplineModel) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineModel::max(self : MathapproxsplineModel) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineModel::to_string(self : MathapproxsplineModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_layer_make(size : Int) -> MathapproxsplineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineLayer::len(self : MathapproxsplineLayer) -> Int { self.size }

pub fn MathapproxsplineLayer::get(self : MathapproxsplineLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineLayer::set(self : MathapproxsplineLayer, i : Int, v : Double) -> MathapproxsplineLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineLayer::sum(self : MathapproxsplineLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineLayer::mean(self : MathapproxsplineLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineLayer::scale(self : MathapproxsplineLayer, f : Double) -> MathapproxsplineLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineLayer::add(self : MathapproxsplineLayer, other : MathapproxsplineLayer) -> MathapproxsplineLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineLayer::copy(self : MathapproxsplineLayer) -> MathapproxsplineLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineLayer::fill(self : MathapproxsplineLayer, v : Double) -> MathapproxsplineLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineLayer::min(self : MathapproxsplineLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineLayer::max(self : MathapproxsplineLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineLayer::to_string(self : MathapproxsplineLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_buffer_make(size : Int) -> MathapproxsplineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineBuffer::len(self : MathapproxsplineBuffer) -> Int { self.size }

pub fn MathapproxsplineBuffer::get(self : MathapproxsplineBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineBuffer::set(self : MathapproxsplineBuffer, i : Int, v : Double) -> MathapproxsplineBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineBuffer::sum(self : MathapproxsplineBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineBuffer::mean(self : MathapproxsplineBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineBuffer::scale(self : MathapproxsplineBuffer, f : Double) -> MathapproxsplineBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineBuffer::add(self : MathapproxsplineBuffer, other : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineBuffer::copy(self : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineBuffer::fill(self : MathapproxsplineBuffer, v : Double) -> MathapproxsplineBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineBuffer::min(self : MathapproxsplineBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineBuffer::max(self : MathapproxsplineBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineBuffer::to_string(self : MathapproxsplineBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cursor_make(size : Int) -> MathapproxsplineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineCursor::len(self : MathapproxsplineCursor) -> Int { self.size }

pub fn MathapproxsplineCursor::get(self : MathapproxsplineCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineCursor::set(self : MathapproxsplineCursor, i : Int, v : Double) -> MathapproxsplineCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCursor::sum(self : MathapproxsplineCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineCursor::mean(self : MathapproxsplineCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineCursor::scale(self : MathapproxsplineCursor, f : Double) -> MathapproxsplineCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCursor::add(self : MathapproxsplineCursor, other : MathapproxsplineCursor) -> MathapproxsplineCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineCursor::copy(self : MathapproxsplineCursor) -> MathapproxsplineCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCursor::fill(self : MathapproxsplineCursor, v : Double) -> MathapproxsplineCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineCursor::min(self : MathapproxsplineCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineCursor::max(self : MathapproxsplineCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineCursor::to_string(self : MathapproxsplineCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_view_make(size : Int) -> MathapproxsplineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineView::len(self : MathapproxsplineView) -> Int { self.size }

pub fn MathapproxsplineView::get(self : MathapproxsplineView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineView::set(self : MathapproxsplineView, i : Int, v : Double) -> MathapproxsplineView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineView::sum(self : MathapproxsplineView) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineView::mean(self : MathapproxsplineView) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineView::scale(self : MathapproxsplineView, f : Double) -> MathapproxsplineView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineView::add(self : MathapproxsplineView, other : MathapproxsplineView) -> MathapproxsplineView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineView::copy(self : MathapproxsplineView) -> MathapproxsplineView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineView::fill(self : MathapproxsplineView, v : Double) -> MathapproxsplineView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineView::min(self : MathapproxsplineView) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineView::max(self : MathapproxsplineView) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineView::to_string(self : MathapproxsplineView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_range_make(size : Int) -> MathapproxsplineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineRange::len(self : MathapproxsplineRange) -> Int { self.size }

pub fn MathapproxsplineRange::get(self : MathapproxsplineRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineRange::set(self : MathapproxsplineRange, i : Int, v : Double) -> MathapproxsplineRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineRange::sum(self : MathapproxsplineRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineRange::mean(self : MathapproxsplineRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineRange::scale(self : MathapproxsplineRange, f : Double) -> MathapproxsplineRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineRange::add(self : MathapproxsplineRange, other : MathapproxsplineRange) -> MathapproxsplineRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineRange::copy(self : MathapproxsplineRange) -> MathapproxsplineRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineRange::fill(self : MathapproxsplineRange, v : Double) -> MathapproxsplineRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineRange::min(self : MathapproxsplineRange) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineRange::max(self : MathapproxsplineRange) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineRange::to_string(self : MathapproxsplineRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_slice_make(size : Int) -> MathapproxsplineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxsplineSlice::len(self : MathapproxsplineSlice) -> Int { self.size }

pub fn MathapproxsplineSlice::get(self : MathapproxsplineSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxsplineSlice::set(self : MathapproxsplineSlice, i : Int, v : Double) -> MathapproxsplineSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxsplineSlice::sum(self : MathapproxsplineSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxsplineSlice::mean(self : MathapproxsplineSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxsplineSlice::scale(self : MathapproxsplineSlice, f : Double) -> MathapproxsplineSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineSlice::add(self : MathapproxsplineSlice, other : MathapproxsplineSlice) -> MathapproxsplineSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxsplineSlice::copy(self : MathapproxsplineSlice) -> MathapproxsplineSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineSlice::fill(self : MathapproxsplineSlice, v : Double) -> MathapproxsplineSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxsplineSlice::min(self : MathapproxsplineSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxsplineSlice::max(self : MathapproxsplineSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxsplineSlice::to_string(self : MathapproxsplineSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

