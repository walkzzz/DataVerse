///===
/// extcore/image_filter_laplacian

pub(all) struct ImagefilterlaplacianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_laplacian_make_point(x : Double, y : Double) -> ImagefilterlaplacianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_laplacian_make_point3(x : Double, y : Double, z : Double) -> ImagefilterlaplacianPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefilterlaplacianPoint::x(self : ImagefilterlaplacianPoint) -> Double { self.x }

pub fn ImagefilterlaplacianPoint::y(self : ImagefilterlaplacianPoint) -> Double { self.y }

pub fn ImagefilterlaplacianPoint::z(self : ImagefilterlaplacianPoint) -> Double { self.z }

pub fn ImagefilterlaplacianPoint::label(self : ImagefilterlaplacianPoint) -> Int { self.label }

pub fn ImagefilterlaplacianPoint::dist(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefilterlaplacianPoint::add(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefilterlaplacianPoint::sub(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefilterlaplacianPoint::scale(self : ImagefilterlaplacianPoint, s : Double) -> ImagefilterlaplacianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefilterlaplacianPoint::dot(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefilterlaplacianPoint::cross(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefilterlaplacianPoint::norm(self : ImagefilterlaplacianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefilterlaplacianPoint::normalize(self : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterlaplacianPoint::negate(self : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefilterlaplacianPoint::mid(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefilterlaplacianPoint::lerp(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint, t : Double) -> ImagefilterlaplacianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefilterlaplacianPoint::to_string(self : ImagefilterlaplacianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_laplacian_make_series(vals : Array[Double], name : String) -> ImagefilterlaplacianSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefilterlaplacianSeries::len(self : ImagefilterlaplacianSeries) -> Int { self.vals.length() }

pub fn ImagefilterlaplacianSeries::sum(self : ImagefilterlaplacianSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefilterlaplacianSeries::mean(self : ImagefilterlaplacianSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefilterlaplacianSeries::min(self : ImagefilterlaplacianSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefilterlaplacianSeries::max(self : ImagefilterlaplacianSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefilterlaplacianSeries::range(self : ImagefilterlaplacianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefilterlaplacianSeries::variance(self : ImagefilterlaplacianSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefilterlaplacianSeries::std(self : ImagefilterlaplacianSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefilterlaplacianSeries::median(self : ImagefilterlaplacianSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefilterlaplacianSeries::scale(self : ImagefilterlaplacianSeries, f : Double) -> ImagefilterlaplacianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::add(self : ImagefilterlaplacianSeries, other : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::sub(self : ImagefilterlaplacianSeries, other : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::normalize(self : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefilterlaplacianSeries::cumsum(self : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::to_string(self : ImagefilterlaplacianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterlaplacianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_laplacian_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterlaplacianMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_filter_laplacian_matrix_identity(n : Int) -> ImagefilterlaplacianMatrix {
  let m = image_filter_laplacian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefilterlaplacianMatrix::get(self : ImagefilterlaplacianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefilterlaplacianMatrix::transpose(self : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  let result = image_filter_laplacian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefilterlaplacianMatrix::add(self : ImagefilterlaplacianMatrix, other : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_laplacian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefilterlaplacianMatrix::scale(self : ImagefilterlaplacianMatrix, s : Double) -> ImagefilterlaplacianMatrix {
  let result = image_filter_laplacian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefilterlaplacianMatrix::multiply(self : ImagefilterlaplacianMatrix, other : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  if self.cols != other.rows { return image_filter_laplacian_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_laplacian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefilterlaplacianMatrix::trace(self : ImagefilterlaplacianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefilterlaplacianMatrix::det(self : ImagefilterlaplacianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefilterlaplacianMatrix::norm(self : ImagefilterlaplacianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefilterlaplacianMatrix::to_string(self : ImagefilterlaplacianMatrix) -> String {
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

pub(all) struct ImagefilterlaplacianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_laplacian_make_vector(comps : Array[Double]) -> ImagefilterlaplacianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_laplacian_vector_zero(dim : Int) -> ImagefilterlaplacianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefilterlaplacianVector::add(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterlaplacianVector::sub(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterlaplacianVector::scale(self : ImagefilterlaplacianVector, s : Double) -> ImagefilterlaplacianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefilterlaplacianVector::dot(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefilterlaplacianVector::norm(self : ImagefilterlaplacianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefilterlaplacianVector::normalize(self : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterlaplacianVector::dist(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefilterlaplacianVector::to_string(self : ImagefilterlaplacianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterlaplacianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_frame_make(size : Int) -> ImagefilterlaplacianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianFrame::len(self : ImagefilterlaplacianFrame) -> Int { self.size }

pub fn ImagefilterlaplacianFrame::get(self : ImagefilterlaplacianFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianFrame::set(self : ImagefilterlaplacianFrame, i : Int, v : Double) -> ImagefilterlaplacianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianFrame::sum(self : ImagefilterlaplacianFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianFrame::mean(self : ImagefilterlaplacianFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianFrame::scale(self : ImagefilterlaplacianFrame, f : Double) -> ImagefilterlaplacianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianFrame::add(self : ImagefilterlaplacianFrame, other : ImagefilterlaplacianFrame) -> ImagefilterlaplacianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianFrame::copy(self : ImagefilterlaplacianFrame) -> ImagefilterlaplacianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianFrame::fill(self : ImagefilterlaplacianFrame, v : Double) -> ImagefilterlaplacianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianFrame::min(self : ImagefilterlaplacianFrame) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianFrame::max(self : ImagefilterlaplacianFrame) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianFrame::to_string(self : ImagefilterlaplacianFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_table_make(size : Int) -> ImagefilterlaplacianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianTable::len(self : ImagefilterlaplacianTable) -> Int { self.size }

pub fn ImagefilterlaplacianTable::get(self : ImagefilterlaplacianTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianTable::set(self : ImagefilterlaplacianTable, i : Int, v : Double) -> ImagefilterlaplacianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianTable::sum(self : ImagefilterlaplacianTable) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianTable::mean(self : ImagefilterlaplacianTable) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianTable::scale(self : ImagefilterlaplacianTable, f : Double) -> ImagefilterlaplacianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianTable::add(self : ImagefilterlaplacianTable, other : ImagefilterlaplacianTable) -> ImagefilterlaplacianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianTable::copy(self : ImagefilterlaplacianTable) -> ImagefilterlaplacianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianTable::fill(self : ImagefilterlaplacianTable, v : Double) -> ImagefilterlaplacianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianTable::min(self : ImagefilterlaplacianTable) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianTable::max(self : ImagefilterlaplacianTable) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianTable::to_string(self : ImagefilterlaplacianTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_graphn_make(size : Int) -> ImagefilterlaplacianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianGraphN::len(self : ImagefilterlaplacianGraphN) -> Int { self.size }

pub fn ImagefilterlaplacianGraphN::get(self : ImagefilterlaplacianGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianGraphN::set(self : ImagefilterlaplacianGraphN, i : Int, v : Double) -> ImagefilterlaplacianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianGraphN::sum(self : ImagefilterlaplacianGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianGraphN::mean(self : ImagefilterlaplacianGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianGraphN::scale(self : ImagefilterlaplacianGraphN, f : Double) -> ImagefilterlaplacianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianGraphN::add(self : ImagefilterlaplacianGraphN, other : ImagefilterlaplacianGraphN) -> ImagefilterlaplacianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianGraphN::copy(self : ImagefilterlaplacianGraphN) -> ImagefilterlaplacianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianGraphN::fill(self : ImagefilterlaplacianGraphN, v : Double) -> ImagefilterlaplacianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianGraphN::min(self : ImagefilterlaplacianGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianGraphN::max(self : ImagefilterlaplacianGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianGraphN::to_string(self : ImagefilterlaplacianGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_node_make(size : Int) -> ImagefilterlaplacianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianNode::len(self : ImagefilterlaplacianNode) -> Int { self.size }

pub fn ImagefilterlaplacianNode::get(self : ImagefilterlaplacianNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianNode::set(self : ImagefilterlaplacianNode, i : Int, v : Double) -> ImagefilterlaplacianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianNode::sum(self : ImagefilterlaplacianNode) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianNode::mean(self : ImagefilterlaplacianNode) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianNode::scale(self : ImagefilterlaplacianNode, f : Double) -> ImagefilterlaplacianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianNode::add(self : ImagefilterlaplacianNode, other : ImagefilterlaplacianNode) -> ImagefilterlaplacianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianNode::copy(self : ImagefilterlaplacianNode) -> ImagefilterlaplacianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianNode::fill(self : ImagefilterlaplacianNode, v : Double) -> ImagefilterlaplacianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianNode::min(self : ImagefilterlaplacianNode) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianNode::max(self : ImagefilterlaplacianNode) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianNode::to_string(self : ImagefilterlaplacianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_edge_make(size : Int) -> ImagefilterlaplacianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianEdge::len(self : ImagefilterlaplacianEdge) -> Int { self.size }

pub fn ImagefilterlaplacianEdge::get(self : ImagefilterlaplacianEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianEdge::set(self : ImagefilterlaplacianEdge, i : Int, v : Double) -> ImagefilterlaplacianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianEdge::sum(self : ImagefilterlaplacianEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianEdge::mean(self : ImagefilterlaplacianEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianEdge::scale(self : ImagefilterlaplacianEdge, f : Double) -> ImagefilterlaplacianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianEdge::add(self : ImagefilterlaplacianEdge, other : ImagefilterlaplacianEdge) -> ImagefilterlaplacianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianEdge::copy(self : ImagefilterlaplacianEdge) -> ImagefilterlaplacianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianEdge::fill(self : ImagefilterlaplacianEdge, v : Double) -> ImagefilterlaplacianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianEdge::min(self : ImagefilterlaplacianEdge) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianEdge::max(self : ImagefilterlaplacianEdge) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianEdge::to_string(self : ImagefilterlaplacianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_path_make(size : Int) -> ImagefilterlaplacianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianPath::len(self : ImagefilterlaplacianPath) -> Int { self.size }

pub fn ImagefilterlaplacianPath::get(self : ImagefilterlaplacianPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianPath::set(self : ImagefilterlaplacianPath, i : Int, v : Double) -> ImagefilterlaplacianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianPath::sum(self : ImagefilterlaplacianPath) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianPath::mean(self : ImagefilterlaplacianPath) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianPath::scale(self : ImagefilterlaplacianPath, f : Double) -> ImagefilterlaplacianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianPath::add(self : ImagefilterlaplacianPath, other : ImagefilterlaplacianPath) -> ImagefilterlaplacianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianPath::copy(self : ImagefilterlaplacianPath) -> ImagefilterlaplacianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianPath::fill(self : ImagefilterlaplacianPath, v : Double) -> ImagefilterlaplacianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianPath::min(self : ImagefilterlaplacianPath) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianPath::max(self : ImagefilterlaplacianPath) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianPath::to_string(self : ImagefilterlaplacianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_cluster_make(size : Int) -> ImagefilterlaplacianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianCluster::len(self : ImagefilterlaplacianCluster) -> Int { self.size }

pub fn ImagefilterlaplacianCluster::get(self : ImagefilterlaplacianCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianCluster::set(self : ImagefilterlaplacianCluster, i : Int, v : Double) -> ImagefilterlaplacianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCluster::sum(self : ImagefilterlaplacianCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianCluster::mean(self : ImagefilterlaplacianCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianCluster::scale(self : ImagefilterlaplacianCluster, f : Double) -> ImagefilterlaplacianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCluster::add(self : ImagefilterlaplacianCluster, other : ImagefilterlaplacianCluster) -> ImagefilterlaplacianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianCluster::copy(self : ImagefilterlaplacianCluster) -> ImagefilterlaplacianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCluster::fill(self : ImagefilterlaplacianCluster, v : Double) -> ImagefilterlaplacianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCluster::min(self : ImagefilterlaplacianCluster) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianCluster::max(self : ImagefilterlaplacianCluster) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianCluster::to_string(self : ImagefilterlaplacianCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_model_make(size : Int) -> ImagefilterlaplacianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianModel::len(self : ImagefilterlaplacianModel) -> Int { self.size }

pub fn ImagefilterlaplacianModel::get(self : ImagefilterlaplacianModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianModel::set(self : ImagefilterlaplacianModel, i : Int, v : Double) -> ImagefilterlaplacianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianModel::sum(self : ImagefilterlaplacianModel) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianModel::mean(self : ImagefilterlaplacianModel) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianModel::scale(self : ImagefilterlaplacianModel, f : Double) -> ImagefilterlaplacianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianModel::add(self : ImagefilterlaplacianModel, other : ImagefilterlaplacianModel) -> ImagefilterlaplacianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianModel::copy(self : ImagefilterlaplacianModel) -> ImagefilterlaplacianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianModel::fill(self : ImagefilterlaplacianModel, v : Double) -> ImagefilterlaplacianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianModel::min(self : ImagefilterlaplacianModel) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianModel::max(self : ImagefilterlaplacianModel) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianModel::to_string(self : ImagefilterlaplacianModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_layer_make(size : Int) -> ImagefilterlaplacianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianLayer::len(self : ImagefilterlaplacianLayer) -> Int { self.size }

pub fn ImagefilterlaplacianLayer::get(self : ImagefilterlaplacianLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianLayer::set(self : ImagefilterlaplacianLayer, i : Int, v : Double) -> ImagefilterlaplacianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianLayer::sum(self : ImagefilterlaplacianLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianLayer::mean(self : ImagefilterlaplacianLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianLayer::scale(self : ImagefilterlaplacianLayer, f : Double) -> ImagefilterlaplacianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianLayer::add(self : ImagefilterlaplacianLayer, other : ImagefilterlaplacianLayer) -> ImagefilterlaplacianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianLayer::copy(self : ImagefilterlaplacianLayer) -> ImagefilterlaplacianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianLayer::fill(self : ImagefilterlaplacianLayer, v : Double) -> ImagefilterlaplacianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianLayer::min(self : ImagefilterlaplacianLayer) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianLayer::max(self : ImagefilterlaplacianLayer) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianLayer::to_string(self : ImagefilterlaplacianLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_buffer_make(size : Int) -> ImagefilterlaplacianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianBuffer::len(self : ImagefilterlaplacianBuffer) -> Int { self.size }

pub fn ImagefilterlaplacianBuffer::get(self : ImagefilterlaplacianBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianBuffer::set(self : ImagefilterlaplacianBuffer, i : Int, v : Double) -> ImagefilterlaplacianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianBuffer::sum(self : ImagefilterlaplacianBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianBuffer::mean(self : ImagefilterlaplacianBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianBuffer::scale(self : ImagefilterlaplacianBuffer, f : Double) -> ImagefilterlaplacianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianBuffer::add(self : ImagefilterlaplacianBuffer, other : ImagefilterlaplacianBuffer) -> ImagefilterlaplacianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianBuffer::copy(self : ImagefilterlaplacianBuffer) -> ImagefilterlaplacianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianBuffer::fill(self : ImagefilterlaplacianBuffer, v : Double) -> ImagefilterlaplacianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianBuffer::min(self : ImagefilterlaplacianBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianBuffer::max(self : ImagefilterlaplacianBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianBuffer::to_string(self : ImagefilterlaplacianBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_cursor_make(size : Int) -> ImagefilterlaplacianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianCursor::len(self : ImagefilterlaplacianCursor) -> Int { self.size }

pub fn ImagefilterlaplacianCursor::get(self : ImagefilterlaplacianCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianCursor::set(self : ImagefilterlaplacianCursor, i : Int, v : Double) -> ImagefilterlaplacianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCursor::sum(self : ImagefilterlaplacianCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianCursor::mean(self : ImagefilterlaplacianCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianCursor::scale(self : ImagefilterlaplacianCursor, f : Double) -> ImagefilterlaplacianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCursor::add(self : ImagefilterlaplacianCursor, other : ImagefilterlaplacianCursor) -> ImagefilterlaplacianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianCursor::copy(self : ImagefilterlaplacianCursor) -> ImagefilterlaplacianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCursor::fill(self : ImagefilterlaplacianCursor, v : Double) -> ImagefilterlaplacianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianCursor::min(self : ImagefilterlaplacianCursor) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianCursor::max(self : ImagefilterlaplacianCursor) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianCursor::to_string(self : ImagefilterlaplacianCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_view_make(size : Int) -> ImagefilterlaplacianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianView::len(self : ImagefilterlaplacianView) -> Int { self.size }

pub fn ImagefilterlaplacianView::get(self : ImagefilterlaplacianView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianView::set(self : ImagefilterlaplacianView, i : Int, v : Double) -> ImagefilterlaplacianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianView::sum(self : ImagefilterlaplacianView) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianView::mean(self : ImagefilterlaplacianView) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianView::scale(self : ImagefilterlaplacianView, f : Double) -> ImagefilterlaplacianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianView::add(self : ImagefilterlaplacianView, other : ImagefilterlaplacianView) -> ImagefilterlaplacianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianView::copy(self : ImagefilterlaplacianView) -> ImagefilterlaplacianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianView::fill(self : ImagefilterlaplacianView, v : Double) -> ImagefilterlaplacianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianView::min(self : ImagefilterlaplacianView) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianView::max(self : ImagefilterlaplacianView) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianView::to_string(self : ImagefilterlaplacianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_range_make(size : Int) -> ImagefilterlaplacianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianRange::len(self : ImagefilterlaplacianRange) -> Int { self.size }

pub fn ImagefilterlaplacianRange::get(self : ImagefilterlaplacianRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianRange::set(self : ImagefilterlaplacianRange, i : Int, v : Double) -> ImagefilterlaplacianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianRange::sum(self : ImagefilterlaplacianRange) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianRange::mean(self : ImagefilterlaplacianRange) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianRange::scale(self : ImagefilterlaplacianRange, f : Double) -> ImagefilterlaplacianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianRange::add(self : ImagefilterlaplacianRange, other : ImagefilterlaplacianRange) -> ImagefilterlaplacianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianRange::copy(self : ImagefilterlaplacianRange) -> ImagefilterlaplacianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianRange::fill(self : ImagefilterlaplacianRange, v : Double) -> ImagefilterlaplacianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianRange::min(self : ImagefilterlaplacianRange) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianRange::max(self : ImagefilterlaplacianRange) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianRange::to_string(self : ImagefilterlaplacianRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_slice_make(size : Int) -> ImagefilterlaplacianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterlaplacianSlice::len(self : ImagefilterlaplacianSlice) -> Int { self.size }

pub fn ImagefilterlaplacianSlice::get(self : ImagefilterlaplacianSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterlaplacianSlice::set(self : ImagefilterlaplacianSlice, i : Int, v : Double) -> ImagefilterlaplacianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianSlice::sum(self : ImagefilterlaplacianSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefilterlaplacianSlice::mean(self : ImagefilterlaplacianSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefilterlaplacianSlice::scale(self : ImagefilterlaplacianSlice, f : Double) -> ImagefilterlaplacianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianSlice::add(self : ImagefilterlaplacianSlice, other : ImagefilterlaplacianSlice) -> ImagefilterlaplacianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterlaplacianSlice::copy(self : ImagefilterlaplacianSlice) -> ImagefilterlaplacianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianSlice::fill(self : ImagefilterlaplacianSlice, v : Double) -> ImagefilterlaplacianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterlaplacianSlice::min(self : ImagefilterlaplacianSlice) -> Double { @_common.min(self.data) }

pub fn ImagefilterlaplacianSlice::max(self : ImagefilterlaplacianSlice) -> Double { @_common.max(self.data) }

pub fn ImagefilterlaplacianSlice::to_string(self : ImagefilterlaplacianSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

