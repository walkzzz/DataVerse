///===
/// extcore/image_filter_canny

pub(all) struct ImagefiltercannyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_canny_make_point(x : Double, y : Double) -> ImagefiltercannyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_canny_make_point3(x : Double, y : Double, z : Double) -> ImagefiltercannyPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltercannyPoint::x(self : ImagefiltercannyPoint) -> Double { self.x }

pub fn ImagefiltercannyPoint::y(self : ImagefiltercannyPoint) -> Double { self.y }

pub fn ImagefiltercannyPoint::z(self : ImagefiltercannyPoint) -> Double { self.z }

pub fn ImagefiltercannyPoint::label(self : ImagefiltercannyPoint) -> Int { self.label }

pub fn ImagefiltercannyPoint::dist(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltercannyPoint::add(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltercannyPoint::sub(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltercannyPoint::scale(self : ImagefiltercannyPoint, s : Double) -> ImagefiltercannyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltercannyPoint::dot(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltercannyPoint::cross(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltercannyPoint::norm(self : ImagefiltercannyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltercannyPoint::normalize(self : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltercannyPoint::negate(self : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltercannyPoint::mid(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltercannyPoint::lerp(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint, t : Double) -> ImagefiltercannyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltercannyPoint::to_string(self : ImagefiltercannyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltercannySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_canny_make_series(vals : Array[Double], name : String) -> ImagefiltercannySeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltercannySeries::len(self : ImagefiltercannySeries) -> Int { self.vals.length() }

pub fn ImagefiltercannySeries::sum(self : ImagefiltercannySeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltercannySeries::mean(self : ImagefiltercannySeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltercannySeries::min(self : ImagefiltercannySeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltercannySeries::max(self : ImagefiltercannySeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltercannySeries::range(self : ImagefiltercannySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltercannySeries::variance(self : ImagefiltercannySeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltercannySeries::std(self : ImagefiltercannySeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltercannySeries::median(self : ImagefiltercannySeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltercannySeries::scale(self : ImagefiltercannySeries, f : Double) -> ImagefiltercannySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltercannySeries::add(self : ImagefiltercannySeries, other : ImagefiltercannySeries) -> ImagefiltercannySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltercannySeries::sub(self : ImagefiltercannySeries, other : ImagefiltercannySeries) -> ImagefiltercannySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltercannySeries::normalize(self : ImagefiltercannySeries) -> ImagefiltercannySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltercannySeries::cumsum(self : ImagefiltercannySeries) -> ImagefiltercannySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltercannySeries::to_string(self : ImagefiltercannySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltercannyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_canny_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltercannyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_canny_matrix_identity(n : Int) -> ImagefiltercannyMatrix {
  let m = image_filter_canny_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltercannyMatrix::get(self : ImagefiltercannyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltercannyMatrix::transpose(self : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  let result = image_filter_canny_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltercannyMatrix::add(self : ImagefiltercannyMatrix, other : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_canny_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltercannyMatrix::scale(self : ImagefiltercannyMatrix, s : Double) -> ImagefiltercannyMatrix {
  let result = image_filter_canny_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltercannyMatrix::multiply(self : ImagefiltercannyMatrix, other : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  if self.cols != other.rows { return image_filter_canny_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_canny_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefiltercannyMatrix::trace(self : ImagefiltercannyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltercannyMatrix::det(self : ImagefiltercannyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltercannyMatrix::norm(self : ImagefiltercannyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltercannyMatrix::to_string(self : ImagefiltercannyMatrix) -> String {
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

pub(all) struct ImagefiltercannyVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_canny_make_vector(comps : Array[Double]) -> ImagefiltercannyVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_canny_vector_zero(dim : Int) -> ImagefiltercannyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltercannyVector::add(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltercannyVector::sub(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltercannyVector::scale(self : ImagefiltercannyVector, s : Double) -> ImagefiltercannyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltercannyVector::dot(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltercannyVector::norm(self : ImagefiltercannyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltercannyVector::normalize(self : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltercannyVector::dist(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltercannyVector::to_string(self : ImagefiltercannyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltercannyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_frame_make(size : Int) -> ImagefiltercannyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyFrame::len(self : ImagefiltercannyFrame) -> Int { self.size }

pub fn ImagefiltercannyFrame::get(self : ImagefiltercannyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyFrame::set(self : ImagefiltercannyFrame, i : Int, v : Double) -> ImagefiltercannyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyFrame::sum(self : ImagefiltercannyFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyFrame::mean(self : ImagefiltercannyFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyFrame::scale(self : ImagefiltercannyFrame, f : Double) -> ImagefiltercannyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyFrame::add(self : ImagefiltercannyFrame, other : ImagefiltercannyFrame) -> ImagefiltercannyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyFrame::copy(self : ImagefiltercannyFrame) -> ImagefiltercannyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyFrame::fill(self : ImagefiltercannyFrame, v : Double) -> ImagefiltercannyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyFrame::min(self : ImagefiltercannyFrame) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyFrame::max(self : ImagefiltercannyFrame) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyFrame::to_string(self : ImagefiltercannyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_table_make(size : Int) -> ImagefiltercannyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyTable::len(self : ImagefiltercannyTable) -> Int { self.size }

pub fn ImagefiltercannyTable::get(self : ImagefiltercannyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyTable::set(self : ImagefiltercannyTable, i : Int, v : Double) -> ImagefiltercannyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyTable::sum(self : ImagefiltercannyTable) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyTable::mean(self : ImagefiltercannyTable) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyTable::scale(self : ImagefiltercannyTable, f : Double) -> ImagefiltercannyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyTable::add(self : ImagefiltercannyTable, other : ImagefiltercannyTable) -> ImagefiltercannyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyTable::copy(self : ImagefiltercannyTable) -> ImagefiltercannyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyTable::fill(self : ImagefiltercannyTable, v : Double) -> ImagefiltercannyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyTable::min(self : ImagefiltercannyTable) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyTable::max(self : ImagefiltercannyTable) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyTable::to_string(self : ImagefiltercannyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_graphn_make(size : Int) -> ImagefiltercannyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyGraphN::len(self : ImagefiltercannyGraphN) -> Int { self.size }

pub fn ImagefiltercannyGraphN::get(self : ImagefiltercannyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyGraphN::set(self : ImagefiltercannyGraphN, i : Int, v : Double) -> ImagefiltercannyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyGraphN::sum(self : ImagefiltercannyGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyGraphN::mean(self : ImagefiltercannyGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyGraphN::scale(self : ImagefiltercannyGraphN, f : Double) -> ImagefiltercannyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyGraphN::add(self : ImagefiltercannyGraphN, other : ImagefiltercannyGraphN) -> ImagefiltercannyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyGraphN::copy(self : ImagefiltercannyGraphN) -> ImagefiltercannyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyGraphN::fill(self : ImagefiltercannyGraphN, v : Double) -> ImagefiltercannyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyGraphN::min(self : ImagefiltercannyGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyGraphN::max(self : ImagefiltercannyGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyGraphN::to_string(self : ImagefiltercannyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_node_make(size : Int) -> ImagefiltercannyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyNode::len(self : ImagefiltercannyNode) -> Int { self.size }

pub fn ImagefiltercannyNode::get(self : ImagefiltercannyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyNode::set(self : ImagefiltercannyNode, i : Int, v : Double) -> ImagefiltercannyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyNode::sum(self : ImagefiltercannyNode) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyNode::mean(self : ImagefiltercannyNode) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyNode::scale(self : ImagefiltercannyNode, f : Double) -> ImagefiltercannyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyNode::add(self : ImagefiltercannyNode, other : ImagefiltercannyNode) -> ImagefiltercannyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyNode::copy(self : ImagefiltercannyNode) -> ImagefiltercannyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyNode::fill(self : ImagefiltercannyNode, v : Double) -> ImagefiltercannyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyNode::min(self : ImagefiltercannyNode) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyNode::max(self : ImagefiltercannyNode) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyNode::to_string(self : ImagefiltercannyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_edge_make(size : Int) -> ImagefiltercannyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyEdge::len(self : ImagefiltercannyEdge) -> Int { self.size }

pub fn ImagefiltercannyEdge::get(self : ImagefiltercannyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyEdge::set(self : ImagefiltercannyEdge, i : Int, v : Double) -> ImagefiltercannyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyEdge::sum(self : ImagefiltercannyEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyEdge::mean(self : ImagefiltercannyEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyEdge::scale(self : ImagefiltercannyEdge, f : Double) -> ImagefiltercannyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyEdge::add(self : ImagefiltercannyEdge, other : ImagefiltercannyEdge) -> ImagefiltercannyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyEdge::copy(self : ImagefiltercannyEdge) -> ImagefiltercannyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyEdge::fill(self : ImagefiltercannyEdge, v : Double) -> ImagefiltercannyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyEdge::min(self : ImagefiltercannyEdge) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyEdge::max(self : ImagefiltercannyEdge) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyEdge::to_string(self : ImagefiltercannyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_path_make(size : Int) -> ImagefiltercannyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyPath::len(self : ImagefiltercannyPath) -> Int { self.size }

pub fn ImagefiltercannyPath::get(self : ImagefiltercannyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyPath::set(self : ImagefiltercannyPath, i : Int, v : Double) -> ImagefiltercannyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyPath::sum(self : ImagefiltercannyPath) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyPath::mean(self : ImagefiltercannyPath) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyPath::scale(self : ImagefiltercannyPath, f : Double) -> ImagefiltercannyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyPath::add(self : ImagefiltercannyPath, other : ImagefiltercannyPath) -> ImagefiltercannyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyPath::copy(self : ImagefiltercannyPath) -> ImagefiltercannyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyPath::fill(self : ImagefiltercannyPath, v : Double) -> ImagefiltercannyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyPath::min(self : ImagefiltercannyPath) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyPath::max(self : ImagefiltercannyPath) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyPath::to_string(self : ImagefiltercannyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_cluster_make(size : Int) -> ImagefiltercannyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyCluster::len(self : ImagefiltercannyCluster) -> Int { self.size }

pub fn ImagefiltercannyCluster::get(self : ImagefiltercannyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyCluster::set(self : ImagefiltercannyCluster, i : Int, v : Double) -> ImagefiltercannyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCluster::sum(self : ImagefiltercannyCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyCluster::mean(self : ImagefiltercannyCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyCluster::scale(self : ImagefiltercannyCluster, f : Double) -> ImagefiltercannyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCluster::add(self : ImagefiltercannyCluster, other : ImagefiltercannyCluster) -> ImagefiltercannyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyCluster::copy(self : ImagefiltercannyCluster) -> ImagefiltercannyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCluster::fill(self : ImagefiltercannyCluster, v : Double) -> ImagefiltercannyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCluster::min(self : ImagefiltercannyCluster) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyCluster::max(self : ImagefiltercannyCluster) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyCluster::to_string(self : ImagefiltercannyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_model_make(size : Int) -> ImagefiltercannyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyModel::len(self : ImagefiltercannyModel) -> Int { self.size }

pub fn ImagefiltercannyModel::get(self : ImagefiltercannyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyModel::set(self : ImagefiltercannyModel, i : Int, v : Double) -> ImagefiltercannyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyModel::sum(self : ImagefiltercannyModel) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyModel::mean(self : ImagefiltercannyModel) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyModel::scale(self : ImagefiltercannyModel, f : Double) -> ImagefiltercannyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyModel::add(self : ImagefiltercannyModel, other : ImagefiltercannyModel) -> ImagefiltercannyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyModel::copy(self : ImagefiltercannyModel) -> ImagefiltercannyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyModel::fill(self : ImagefiltercannyModel, v : Double) -> ImagefiltercannyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyModel::min(self : ImagefiltercannyModel) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyModel::max(self : ImagefiltercannyModel) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyModel::to_string(self : ImagefiltercannyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_layer_make(size : Int) -> ImagefiltercannyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyLayer::len(self : ImagefiltercannyLayer) -> Int { self.size }

pub fn ImagefiltercannyLayer::get(self : ImagefiltercannyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyLayer::set(self : ImagefiltercannyLayer, i : Int, v : Double) -> ImagefiltercannyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyLayer::sum(self : ImagefiltercannyLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyLayer::mean(self : ImagefiltercannyLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyLayer::scale(self : ImagefiltercannyLayer, f : Double) -> ImagefiltercannyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyLayer::add(self : ImagefiltercannyLayer, other : ImagefiltercannyLayer) -> ImagefiltercannyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyLayer::copy(self : ImagefiltercannyLayer) -> ImagefiltercannyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyLayer::fill(self : ImagefiltercannyLayer, v : Double) -> ImagefiltercannyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyLayer::min(self : ImagefiltercannyLayer) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyLayer::max(self : ImagefiltercannyLayer) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyLayer::to_string(self : ImagefiltercannyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_buffer_make(size : Int) -> ImagefiltercannyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyBuffer::len(self : ImagefiltercannyBuffer) -> Int { self.size }

pub fn ImagefiltercannyBuffer::get(self : ImagefiltercannyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyBuffer::set(self : ImagefiltercannyBuffer, i : Int, v : Double) -> ImagefiltercannyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyBuffer::sum(self : ImagefiltercannyBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyBuffer::mean(self : ImagefiltercannyBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyBuffer::scale(self : ImagefiltercannyBuffer, f : Double) -> ImagefiltercannyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyBuffer::add(self : ImagefiltercannyBuffer, other : ImagefiltercannyBuffer) -> ImagefiltercannyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyBuffer::copy(self : ImagefiltercannyBuffer) -> ImagefiltercannyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyBuffer::fill(self : ImagefiltercannyBuffer, v : Double) -> ImagefiltercannyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyBuffer::min(self : ImagefiltercannyBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyBuffer::max(self : ImagefiltercannyBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyBuffer::to_string(self : ImagefiltercannyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_cursor_make(size : Int) -> ImagefiltercannyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyCursor::len(self : ImagefiltercannyCursor) -> Int { self.size }

pub fn ImagefiltercannyCursor::get(self : ImagefiltercannyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyCursor::set(self : ImagefiltercannyCursor, i : Int, v : Double) -> ImagefiltercannyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCursor::sum(self : ImagefiltercannyCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyCursor::mean(self : ImagefiltercannyCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyCursor::scale(self : ImagefiltercannyCursor, f : Double) -> ImagefiltercannyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCursor::add(self : ImagefiltercannyCursor, other : ImagefiltercannyCursor) -> ImagefiltercannyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyCursor::copy(self : ImagefiltercannyCursor) -> ImagefiltercannyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCursor::fill(self : ImagefiltercannyCursor, v : Double) -> ImagefiltercannyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyCursor::min(self : ImagefiltercannyCursor) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyCursor::max(self : ImagefiltercannyCursor) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyCursor::to_string(self : ImagefiltercannyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_view_make(size : Int) -> ImagefiltercannyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyView::len(self : ImagefiltercannyView) -> Int { self.size }

pub fn ImagefiltercannyView::get(self : ImagefiltercannyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyView::set(self : ImagefiltercannyView, i : Int, v : Double) -> ImagefiltercannyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyView::sum(self : ImagefiltercannyView) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyView::mean(self : ImagefiltercannyView) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyView::scale(self : ImagefiltercannyView, f : Double) -> ImagefiltercannyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyView::add(self : ImagefiltercannyView, other : ImagefiltercannyView) -> ImagefiltercannyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyView::copy(self : ImagefiltercannyView) -> ImagefiltercannyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyView::fill(self : ImagefiltercannyView, v : Double) -> ImagefiltercannyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyView::min(self : ImagefiltercannyView) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyView::max(self : ImagefiltercannyView) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyView::to_string(self : ImagefiltercannyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_range_make(size : Int) -> ImagefiltercannyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannyRange::len(self : ImagefiltercannyRange) -> Int { self.size }

pub fn ImagefiltercannyRange::get(self : ImagefiltercannyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannyRange::set(self : ImagefiltercannyRange, i : Int, v : Double) -> ImagefiltercannyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyRange::sum(self : ImagefiltercannyRange) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannyRange::mean(self : ImagefiltercannyRange) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannyRange::scale(self : ImagefiltercannyRange, f : Double) -> ImagefiltercannyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyRange::add(self : ImagefiltercannyRange, other : ImagefiltercannyRange) -> ImagefiltercannyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannyRange::copy(self : ImagefiltercannyRange) -> ImagefiltercannyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyRange::fill(self : ImagefiltercannyRange, v : Double) -> ImagefiltercannyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannyRange::min(self : ImagefiltercannyRange) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannyRange::max(self : ImagefiltercannyRange) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannyRange::to_string(self : ImagefiltercannyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_slice_make(size : Int) -> ImagefiltercannySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltercannySlice::len(self : ImagefiltercannySlice) -> Int { self.size }

pub fn ImagefiltercannySlice::get(self : ImagefiltercannySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltercannySlice::set(self : ImagefiltercannySlice, i : Int, v : Double) -> ImagefiltercannySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltercannySlice::sum(self : ImagefiltercannySlice) -> Double { @_common.sum(self.data) }

pub fn ImagefiltercannySlice::mean(self : ImagefiltercannySlice) -> Double { @_common.mean(self.data) }

pub fn ImagefiltercannySlice::scale(self : ImagefiltercannySlice, f : Double) -> ImagefiltercannySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannySlice::add(self : ImagefiltercannySlice, other : ImagefiltercannySlice) -> ImagefiltercannySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltercannySlice::copy(self : ImagefiltercannySlice) -> ImagefiltercannySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannySlice::fill(self : ImagefiltercannySlice, v : Double) -> ImagefiltercannySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltercannySlice::min(self : ImagefiltercannySlice) -> Double { @_common.min(self.data) }

pub fn ImagefiltercannySlice::max(self : ImagefiltercannySlice) -> Double { @_common.max(self.data) }

pub fn ImagefiltercannySlice::to_string(self : ImagefiltercannySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

