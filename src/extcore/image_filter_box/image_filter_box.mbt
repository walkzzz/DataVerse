///===
/// extcore/image_filter_box

pub(all) struct ImagefilterboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_box_make_point(x : Double, y : Double) -> ImagefilterboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_box_make_point3(x : Double, y : Double, z : Double) -> ImagefilterboxPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefilterboxPoint::x(self : ImagefilterboxPoint) -> Double { self.x }

pub fn ImagefilterboxPoint::y(self : ImagefilterboxPoint) -> Double { self.y }

pub fn ImagefilterboxPoint::z(self : ImagefilterboxPoint) -> Double { self.z }

pub fn ImagefilterboxPoint::label(self : ImagefilterboxPoint) -> Int { self.label }

pub fn ImagefilterboxPoint::dist(self : ImagefilterboxPoint, other : ImagefilterboxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefilterboxPoint::add(self : ImagefilterboxPoint, other : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefilterboxPoint::sub(self : ImagefilterboxPoint, other : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefilterboxPoint::scale(self : ImagefilterboxPoint, s : Double) -> ImagefilterboxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefilterboxPoint::dot(self : ImagefilterboxPoint, other : ImagefilterboxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefilterboxPoint::cross(self : ImagefilterboxPoint, other : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefilterboxPoint::norm(self : ImagefilterboxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefilterboxPoint::normalize(self : ImagefilterboxPoint) -> ImagefilterboxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterboxPoint::negate(self : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefilterboxPoint::mid(self : ImagefilterboxPoint, other : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefilterboxPoint::lerp(self : ImagefilterboxPoint, other : ImagefilterboxPoint, t : Double) -> ImagefilterboxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefilterboxPoint::to_string(self : ImagefilterboxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefilterboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_box_make_series(vals : Array[Double], name : String) -> ImagefilterboxSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefilterboxSeries::len(self : ImagefilterboxSeries) -> Int { self.vals.length() }

pub fn ImagefilterboxSeries::sum(self : ImagefilterboxSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefilterboxSeries::mean(self : ImagefilterboxSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefilterboxSeries::min(self : ImagefilterboxSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefilterboxSeries::max(self : ImagefilterboxSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefilterboxSeries::range(self : ImagefilterboxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefilterboxSeries::variance(self : ImagefilterboxSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefilterboxSeries::std(self : ImagefilterboxSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefilterboxSeries::median(self : ImagefilterboxSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefilterboxSeries::scale(self : ImagefilterboxSeries, f : Double) -> ImagefilterboxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefilterboxSeries::add(self : ImagefilterboxSeries, other : ImagefilterboxSeries) -> ImagefilterboxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefilterboxSeries::sub(self : ImagefilterboxSeries, other : ImagefilterboxSeries) -> ImagefilterboxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefilterboxSeries::normalize(self : ImagefilterboxSeries) -> ImagefilterboxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefilterboxSeries::cumsum(self : ImagefilterboxSeries) -> ImagefilterboxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefilterboxSeries::to_string(self : ImagefilterboxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_box_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterboxMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_filter_box_matrix_identity(n : Int) -> ImagefilterboxMatrix {
  let m = image_filter_box_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefilterboxMatrix::get(self : ImagefilterboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefilterboxMatrix::transpose(self : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  let result = image_filter_box_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefilterboxMatrix::add(self : ImagefilterboxMatrix, other : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_box_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefilterboxMatrix::scale(self : ImagefilterboxMatrix, s : Double) -> ImagefilterboxMatrix {
  let result = image_filter_box_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefilterboxMatrix::multiply(self : ImagefilterboxMatrix, other : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  if self.cols != other.rows { return image_filter_box_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_box_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefilterboxMatrix::trace(self : ImagefilterboxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefilterboxMatrix::det(self : ImagefilterboxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefilterboxMatrix::norm(self : ImagefilterboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefilterboxMatrix::to_string(self : ImagefilterboxMatrix) -> String {
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

pub(all) struct ImagefilterboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_box_make_vector(comps : Array[Double]) -> ImagefilterboxVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_box_vector_zero(dim : Int) -> ImagefilterboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefilterboxVector::add(self : ImagefilterboxVector, other : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterboxVector::sub(self : ImagefilterboxVector, other : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterboxVector::scale(self : ImagefilterboxVector, s : Double) -> ImagefilterboxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefilterboxVector::dot(self : ImagefilterboxVector, other : ImagefilterboxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefilterboxVector::norm(self : ImagefilterboxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefilterboxVector::normalize(self : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterboxVector::dist(self : ImagefilterboxVector, other : ImagefilterboxVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefilterboxVector::to_string(self : ImagefilterboxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_frame_make(size : Int) -> ImagefilterboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxFrame::len(self : ImagefilterboxFrame) -> Int { self.size }

pub fn ImagefilterboxFrame::get(self : ImagefilterboxFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxFrame::set(self : ImagefilterboxFrame, i : Int, v : Double) -> ImagefilterboxFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxFrame::sum(self : ImagefilterboxFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxFrame::mean(self : ImagefilterboxFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxFrame::scale(self : ImagefilterboxFrame, f : Double) -> ImagefilterboxFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxFrame::add(self : ImagefilterboxFrame, other : ImagefilterboxFrame) -> ImagefilterboxFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxFrame::copy(self : ImagefilterboxFrame) -> ImagefilterboxFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxFrame::fill(self : ImagefilterboxFrame, v : Double) -> ImagefilterboxFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxFrame::min(self : ImagefilterboxFrame) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxFrame::max(self : ImagefilterboxFrame) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxFrame::to_string(self : ImagefilterboxFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_table_make(size : Int) -> ImagefilterboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxTable::len(self : ImagefilterboxTable) -> Int { self.size }

pub fn ImagefilterboxTable::get(self : ImagefilterboxTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxTable::set(self : ImagefilterboxTable, i : Int, v : Double) -> ImagefilterboxTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxTable::sum(self : ImagefilterboxTable) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxTable::mean(self : ImagefilterboxTable) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxTable::scale(self : ImagefilterboxTable, f : Double) -> ImagefilterboxTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxTable::add(self : ImagefilterboxTable, other : ImagefilterboxTable) -> ImagefilterboxTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxTable::copy(self : ImagefilterboxTable) -> ImagefilterboxTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxTable::fill(self : ImagefilterboxTable, v : Double) -> ImagefilterboxTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxTable::min(self : ImagefilterboxTable) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxTable::max(self : ImagefilterboxTable) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxTable::to_string(self : ImagefilterboxTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_graphn_make(size : Int) -> ImagefilterboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxGraphN::len(self : ImagefilterboxGraphN) -> Int { self.size }

pub fn ImagefilterboxGraphN::get(self : ImagefilterboxGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxGraphN::set(self : ImagefilterboxGraphN, i : Int, v : Double) -> ImagefilterboxGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxGraphN::sum(self : ImagefilterboxGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxGraphN::mean(self : ImagefilterboxGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxGraphN::scale(self : ImagefilterboxGraphN, f : Double) -> ImagefilterboxGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxGraphN::add(self : ImagefilterboxGraphN, other : ImagefilterboxGraphN) -> ImagefilterboxGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxGraphN::copy(self : ImagefilterboxGraphN) -> ImagefilterboxGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxGraphN::fill(self : ImagefilterboxGraphN, v : Double) -> ImagefilterboxGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxGraphN::min(self : ImagefilterboxGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxGraphN::max(self : ImagefilterboxGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxGraphN::to_string(self : ImagefilterboxGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_node_make(size : Int) -> ImagefilterboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxNode::len(self : ImagefilterboxNode) -> Int { self.size }

pub fn ImagefilterboxNode::get(self : ImagefilterboxNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxNode::set(self : ImagefilterboxNode, i : Int, v : Double) -> ImagefilterboxNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxNode::sum(self : ImagefilterboxNode) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxNode::mean(self : ImagefilterboxNode) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxNode::scale(self : ImagefilterboxNode, f : Double) -> ImagefilterboxNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxNode::add(self : ImagefilterboxNode, other : ImagefilterboxNode) -> ImagefilterboxNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxNode::copy(self : ImagefilterboxNode) -> ImagefilterboxNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxNode::fill(self : ImagefilterboxNode, v : Double) -> ImagefilterboxNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxNode::min(self : ImagefilterboxNode) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxNode::max(self : ImagefilterboxNode) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxNode::to_string(self : ImagefilterboxNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_edge_make(size : Int) -> ImagefilterboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxEdge::len(self : ImagefilterboxEdge) -> Int { self.size }

pub fn ImagefilterboxEdge::get(self : ImagefilterboxEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxEdge::set(self : ImagefilterboxEdge, i : Int, v : Double) -> ImagefilterboxEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxEdge::sum(self : ImagefilterboxEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxEdge::mean(self : ImagefilterboxEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxEdge::scale(self : ImagefilterboxEdge, f : Double) -> ImagefilterboxEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxEdge::add(self : ImagefilterboxEdge, other : ImagefilterboxEdge) -> ImagefilterboxEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxEdge::copy(self : ImagefilterboxEdge) -> ImagefilterboxEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxEdge::fill(self : ImagefilterboxEdge, v : Double) -> ImagefilterboxEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxEdge::min(self : ImagefilterboxEdge) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxEdge::max(self : ImagefilterboxEdge) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxEdge::to_string(self : ImagefilterboxEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_path_make(size : Int) -> ImagefilterboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxPath::len(self : ImagefilterboxPath) -> Int { self.size }

pub fn ImagefilterboxPath::get(self : ImagefilterboxPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxPath::set(self : ImagefilterboxPath, i : Int, v : Double) -> ImagefilterboxPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxPath::sum(self : ImagefilterboxPath) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxPath::mean(self : ImagefilterboxPath) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxPath::scale(self : ImagefilterboxPath, f : Double) -> ImagefilterboxPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxPath::add(self : ImagefilterboxPath, other : ImagefilterboxPath) -> ImagefilterboxPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxPath::copy(self : ImagefilterboxPath) -> ImagefilterboxPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxPath::fill(self : ImagefilterboxPath, v : Double) -> ImagefilterboxPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxPath::min(self : ImagefilterboxPath) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxPath::max(self : ImagefilterboxPath) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxPath::to_string(self : ImagefilterboxPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_cluster_make(size : Int) -> ImagefilterboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxCluster::len(self : ImagefilterboxCluster) -> Int { self.size }

pub fn ImagefilterboxCluster::get(self : ImagefilterboxCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxCluster::set(self : ImagefilterboxCluster, i : Int, v : Double) -> ImagefilterboxCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCluster::sum(self : ImagefilterboxCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxCluster::mean(self : ImagefilterboxCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxCluster::scale(self : ImagefilterboxCluster, f : Double) -> ImagefilterboxCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCluster::add(self : ImagefilterboxCluster, other : ImagefilterboxCluster) -> ImagefilterboxCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxCluster::copy(self : ImagefilterboxCluster) -> ImagefilterboxCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCluster::fill(self : ImagefilterboxCluster, v : Double) -> ImagefilterboxCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCluster::min(self : ImagefilterboxCluster) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxCluster::max(self : ImagefilterboxCluster) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxCluster::to_string(self : ImagefilterboxCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_model_make(size : Int) -> ImagefilterboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxModel::len(self : ImagefilterboxModel) -> Int { self.size }

pub fn ImagefilterboxModel::get(self : ImagefilterboxModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxModel::set(self : ImagefilterboxModel, i : Int, v : Double) -> ImagefilterboxModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxModel::sum(self : ImagefilterboxModel) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxModel::mean(self : ImagefilterboxModel) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxModel::scale(self : ImagefilterboxModel, f : Double) -> ImagefilterboxModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxModel::add(self : ImagefilterboxModel, other : ImagefilterboxModel) -> ImagefilterboxModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxModel::copy(self : ImagefilterboxModel) -> ImagefilterboxModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxModel::fill(self : ImagefilterboxModel, v : Double) -> ImagefilterboxModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxModel::min(self : ImagefilterboxModel) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxModel::max(self : ImagefilterboxModel) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxModel::to_string(self : ImagefilterboxModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_layer_make(size : Int) -> ImagefilterboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxLayer::len(self : ImagefilterboxLayer) -> Int { self.size }

pub fn ImagefilterboxLayer::get(self : ImagefilterboxLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxLayer::set(self : ImagefilterboxLayer, i : Int, v : Double) -> ImagefilterboxLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxLayer::sum(self : ImagefilterboxLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxLayer::mean(self : ImagefilterboxLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxLayer::scale(self : ImagefilterboxLayer, f : Double) -> ImagefilterboxLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxLayer::add(self : ImagefilterboxLayer, other : ImagefilterboxLayer) -> ImagefilterboxLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxLayer::copy(self : ImagefilterboxLayer) -> ImagefilterboxLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxLayer::fill(self : ImagefilterboxLayer, v : Double) -> ImagefilterboxLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxLayer::min(self : ImagefilterboxLayer) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxLayer::max(self : ImagefilterboxLayer) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxLayer::to_string(self : ImagefilterboxLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_buffer_make(size : Int) -> ImagefilterboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxBuffer::len(self : ImagefilterboxBuffer) -> Int { self.size }

pub fn ImagefilterboxBuffer::get(self : ImagefilterboxBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxBuffer::set(self : ImagefilterboxBuffer, i : Int, v : Double) -> ImagefilterboxBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxBuffer::sum(self : ImagefilterboxBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxBuffer::mean(self : ImagefilterboxBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxBuffer::scale(self : ImagefilterboxBuffer, f : Double) -> ImagefilterboxBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxBuffer::add(self : ImagefilterboxBuffer, other : ImagefilterboxBuffer) -> ImagefilterboxBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxBuffer::copy(self : ImagefilterboxBuffer) -> ImagefilterboxBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxBuffer::fill(self : ImagefilterboxBuffer, v : Double) -> ImagefilterboxBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxBuffer::min(self : ImagefilterboxBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxBuffer::max(self : ImagefilterboxBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxBuffer::to_string(self : ImagefilterboxBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_cursor_make(size : Int) -> ImagefilterboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxCursor::len(self : ImagefilterboxCursor) -> Int { self.size }

pub fn ImagefilterboxCursor::get(self : ImagefilterboxCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxCursor::set(self : ImagefilterboxCursor, i : Int, v : Double) -> ImagefilterboxCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCursor::sum(self : ImagefilterboxCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxCursor::mean(self : ImagefilterboxCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxCursor::scale(self : ImagefilterboxCursor, f : Double) -> ImagefilterboxCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCursor::add(self : ImagefilterboxCursor, other : ImagefilterboxCursor) -> ImagefilterboxCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxCursor::copy(self : ImagefilterboxCursor) -> ImagefilterboxCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCursor::fill(self : ImagefilterboxCursor, v : Double) -> ImagefilterboxCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxCursor::min(self : ImagefilterboxCursor) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxCursor::max(self : ImagefilterboxCursor) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxCursor::to_string(self : ImagefilterboxCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_view_make(size : Int) -> ImagefilterboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxView::len(self : ImagefilterboxView) -> Int { self.size }

pub fn ImagefilterboxView::get(self : ImagefilterboxView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxView::set(self : ImagefilterboxView, i : Int, v : Double) -> ImagefilterboxView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxView::sum(self : ImagefilterboxView) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxView::mean(self : ImagefilterboxView) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxView::scale(self : ImagefilterboxView, f : Double) -> ImagefilterboxView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxView::add(self : ImagefilterboxView, other : ImagefilterboxView) -> ImagefilterboxView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxView::copy(self : ImagefilterboxView) -> ImagefilterboxView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxView::fill(self : ImagefilterboxView, v : Double) -> ImagefilterboxView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxView::min(self : ImagefilterboxView) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxView::max(self : ImagefilterboxView) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxView::to_string(self : ImagefilterboxView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_range_make(size : Int) -> ImagefilterboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxRange::len(self : ImagefilterboxRange) -> Int { self.size }

pub fn ImagefilterboxRange::get(self : ImagefilterboxRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxRange::set(self : ImagefilterboxRange, i : Int, v : Double) -> ImagefilterboxRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxRange::sum(self : ImagefilterboxRange) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxRange::mean(self : ImagefilterboxRange) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxRange::scale(self : ImagefilterboxRange, f : Double) -> ImagefilterboxRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxRange::add(self : ImagefilterboxRange, other : ImagefilterboxRange) -> ImagefilterboxRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxRange::copy(self : ImagefilterboxRange) -> ImagefilterboxRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxRange::fill(self : ImagefilterboxRange, v : Double) -> ImagefilterboxRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxRange::min(self : ImagefilterboxRange) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxRange::max(self : ImagefilterboxRange) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxRange::to_string(self : ImagefilterboxRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_slice_make(size : Int) -> ImagefilterboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterboxSlice::len(self : ImagefilterboxSlice) -> Int { self.size }

pub fn ImagefilterboxSlice::get(self : ImagefilterboxSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterboxSlice::set(self : ImagefilterboxSlice, i : Int, v : Double) -> ImagefilterboxSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterboxSlice::sum(self : ImagefilterboxSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefilterboxSlice::mean(self : ImagefilterboxSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefilterboxSlice::scale(self : ImagefilterboxSlice, f : Double) -> ImagefilterboxSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxSlice::add(self : ImagefilterboxSlice, other : ImagefilterboxSlice) -> ImagefilterboxSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterboxSlice::copy(self : ImagefilterboxSlice) -> ImagefilterboxSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxSlice::fill(self : ImagefilterboxSlice, v : Double) -> ImagefilterboxSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterboxSlice::min(self : ImagefilterboxSlice) -> Double { @_common.min(self.data) }

pub fn ImagefilterboxSlice::max(self : ImagefilterboxSlice) -> Double { @_common.max(self.data) }

pub fn ImagefilterboxSlice::to_string(self : ImagefilterboxSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

