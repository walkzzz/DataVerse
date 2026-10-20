///===
/// extcore/image_transform_rotate

pub(all) struct ImagetransformrotatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_rotate_make_point(x : Double, y : Double) -> ImagetransformrotatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_rotate_make_point3(x : Double, y : Double, z : Double) -> ImagetransformrotatePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformrotatePoint::x(self : ImagetransformrotatePoint) -> Double { self.x }

pub fn ImagetransformrotatePoint::y(self : ImagetransformrotatePoint) -> Double { self.y }

pub fn ImagetransformrotatePoint::z(self : ImagetransformrotatePoint) -> Double { self.z }

pub fn ImagetransformrotatePoint::label(self : ImagetransformrotatePoint) -> Int { self.label }

pub fn ImagetransformrotatePoint::dist(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformrotatePoint::add(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformrotatePoint::sub(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformrotatePoint::scale(self : ImagetransformrotatePoint, s : Double) -> ImagetransformrotatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformrotatePoint::dot(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformrotatePoint::cross(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformrotatePoint::norm(self : ImagetransformrotatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformrotatePoint::normalize(self : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformrotatePoint::negate(self : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformrotatePoint::mid(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformrotatePoint::lerp(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint, t : Double) -> ImagetransformrotatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformrotatePoint::to_string(self : ImagetransformrotatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformrotateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_rotate_make_series(vals : Array[Double], name : String) -> ImagetransformrotateSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformrotateSeries::len(self : ImagetransformrotateSeries) -> Int { self.vals.length() }

pub fn ImagetransformrotateSeries::sum(self : ImagetransformrotateSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformrotateSeries::mean(self : ImagetransformrotateSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformrotateSeries::min(self : ImagetransformrotateSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformrotateSeries::max(self : ImagetransformrotateSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformrotateSeries::range(self : ImagetransformrotateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformrotateSeries::variance(self : ImagetransformrotateSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformrotateSeries::std(self : ImagetransformrotateSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformrotateSeries::median(self : ImagetransformrotateSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformrotateSeries::scale(self : ImagetransformrotateSeries, f : Double) -> ImagetransformrotateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformrotateSeries::add(self : ImagetransformrotateSeries, other : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformrotateSeries::sub(self : ImagetransformrotateSeries, other : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformrotateSeries::normalize(self : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformrotateSeries::cumsum(self : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformrotateSeries::to_string(self : ImagetransformrotateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformrotateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_rotate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformrotateMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_transform_rotate_matrix_identity(n : Int) -> ImagetransformrotateMatrix {
  let m = image_transform_rotate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformrotateMatrix::get(self : ImagetransformrotateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformrotateMatrix::transpose(self : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  let result = image_transform_rotate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformrotateMatrix::add(self : ImagetransformrotateMatrix, other : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_rotate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformrotateMatrix::scale(self : ImagetransformrotateMatrix, s : Double) -> ImagetransformrotateMatrix {
  let result = image_transform_rotate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformrotateMatrix::multiply(self : ImagetransformrotateMatrix, other : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  if self.cols != other.rows { return image_transform_rotate_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_rotate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagetransformrotateMatrix::trace(self : ImagetransformrotateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformrotateMatrix::det(self : ImagetransformrotateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformrotateMatrix::norm(self : ImagetransformrotateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformrotateMatrix::to_string(self : ImagetransformrotateMatrix) -> String {
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

pub(all) struct ImagetransformrotateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_rotate_make_vector(comps : Array[Double]) -> ImagetransformrotateVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_rotate_vector_zero(dim : Int) -> ImagetransformrotateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformrotateVector::add(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformrotateVector::sub(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformrotateVector::scale(self : ImagetransformrotateVector, s : Double) -> ImagetransformrotateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformrotateVector::dot(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformrotateVector::norm(self : ImagetransformrotateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformrotateVector::normalize(self : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformrotateVector::dist(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformrotateVector::to_string(self : ImagetransformrotateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformrotateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_frame_make(size : Int) -> ImagetransformrotateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateFrame::len(self : ImagetransformrotateFrame) -> Int { self.size }

pub fn ImagetransformrotateFrame::get(self : ImagetransformrotateFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateFrame::set(self : ImagetransformrotateFrame, i : Int, v : Double) -> ImagetransformrotateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateFrame::sum(self : ImagetransformrotateFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateFrame::mean(self : ImagetransformrotateFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateFrame::scale(self : ImagetransformrotateFrame, f : Double) -> ImagetransformrotateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateFrame::add(self : ImagetransformrotateFrame, other : ImagetransformrotateFrame) -> ImagetransformrotateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateFrame::copy(self : ImagetransformrotateFrame) -> ImagetransformrotateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateFrame::fill(self : ImagetransformrotateFrame, v : Double) -> ImagetransformrotateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateFrame::min(self : ImagetransformrotateFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateFrame::max(self : ImagetransformrotateFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateFrame::to_string(self : ImagetransformrotateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_table_make(size : Int) -> ImagetransformrotateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateTable::len(self : ImagetransformrotateTable) -> Int { self.size }

pub fn ImagetransformrotateTable::get(self : ImagetransformrotateTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateTable::set(self : ImagetransformrotateTable, i : Int, v : Double) -> ImagetransformrotateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateTable::sum(self : ImagetransformrotateTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateTable::mean(self : ImagetransformrotateTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateTable::scale(self : ImagetransformrotateTable, f : Double) -> ImagetransformrotateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateTable::add(self : ImagetransformrotateTable, other : ImagetransformrotateTable) -> ImagetransformrotateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateTable::copy(self : ImagetransformrotateTable) -> ImagetransformrotateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateTable::fill(self : ImagetransformrotateTable, v : Double) -> ImagetransformrotateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateTable::min(self : ImagetransformrotateTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateTable::max(self : ImagetransformrotateTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateTable::to_string(self : ImagetransformrotateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_graphn_make(size : Int) -> ImagetransformrotateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateGraphN::len(self : ImagetransformrotateGraphN) -> Int { self.size }

pub fn ImagetransformrotateGraphN::get(self : ImagetransformrotateGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateGraphN::set(self : ImagetransformrotateGraphN, i : Int, v : Double) -> ImagetransformrotateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateGraphN::sum(self : ImagetransformrotateGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateGraphN::mean(self : ImagetransformrotateGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateGraphN::scale(self : ImagetransformrotateGraphN, f : Double) -> ImagetransformrotateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateGraphN::add(self : ImagetransformrotateGraphN, other : ImagetransformrotateGraphN) -> ImagetransformrotateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateGraphN::copy(self : ImagetransformrotateGraphN) -> ImagetransformrotateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateGraphN::fill(self : ImagetransformrotateGraphN, v : Double) -> ImagetransformrotateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateGraphN::min(self : ImagetransformrotateGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateGraphN::max(self : ImagetransformrotateGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateGraphN::to_string(self : ImagetransformrotateGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_node_make(size : Int) -> ImagetransformrotateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateNode::len(self : ImagetransformrotateNode) -> Int { self.size }

pub fn ImagetransformrotateNode::get(self : ImagetransformrotateNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateNode::set(self : ImagetransformrotateNode, i : Int, v : Double) -> ImagetransformrotateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateNode::sum(self : ImagetransformrotateNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateNode::mean(self : ImagetransformrotateNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateNode::scale(self : ImagetransformrotateNode, f : Double) -> ImagetransformrotateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateNode::add(self : ImagetransformrotateNode, other : ImagetransformrotateNode) -> ImagetransformrotateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateNode::copy(self : ImagetransformrotateNode) -> ImagetransformrotateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateNode::fill(self : ImagetransformrotateNode, v : Double) -> ImagetransformrotateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateNode::min(self : ImagetransformrotateNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateNode::max(self : ImagetransformrotateNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateNode::to_string(self : ImagetransformrotateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_edge_make(size : Int) -> ImagetransformrotateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateEdge::len(self : ImagetransformrotateEdge) -> Int { self.size }

pub fn ImagetransformrotateEdge::get(self : ImagetransformrotateEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateEdge::set(self : ImagetransformrotateEdge, i : Int, v : Double) -> ImagetransformrotateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateEdge::sum(self : ImagetransformrotateEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateEdge::mean(self : ImagetransformrotateEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateEdge::scale(self : ImagetransformrotateEdge, f : Double) -> ImagetransformrotateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateEdge::add(self : ImagetransformrotateEdge, other : ImagetransformrotateEdge) -> ImagetransformrotateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateEdge::copy(self : ImagetransformrotateEdge) -> ImagetransformrotateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateEdge::fill(self : ImagetransformrotateEdge, v : Double) -> ImagetransformrotateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateEdge::min(self : ImagetransformrotateEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateEdge::max(self : ImagetransformrotateEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateEdge::to_string(self : ImagetransformrotateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_path_make(size : Int) -> ImagetransformrotatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotatePath::len(self : ImagetransformrotatePath) -> Int { self.size }

pub fn ImagetransformrotatePath::get(self : ImagetransformrotatePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotatePath::set(self : ImagetransformrotatePath, i : Int, v : Double) -> ImagetransformrotatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotatePath::sum(self : ImagetransformrotatePath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotatePath::mean(self : ImagetransformrotatePath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotatePath::scale(self : ImagetransformrotatePath, f : Double) -> ImagetransformrotatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotatePath::add(self : ImagetransformrotatePath, other : ImagetransformrotatePath) -> ImagetransformrotatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotatePath::copy(self : ImagetransformrotatePath) -> ImagetransformrotatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotatePath::fill(self : ImagetransformrotatePath, v : Double) -> ImagetransformrotatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotatePath::min(self : ImagetransformrotatePath) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotatePath::max(self : ImagetransformrotatePath) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotatePath::to_string(self : ImagetransformrotatePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_cluster_make(size : Int) -> ImagetransformrotateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateCluster::len(self : ImagetransformrotateCluster) -> Int { self.size }

pub fn ImagetransformrotateCluster::get(self : ImagetransformrotateCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateCluster::set(self : ImagetransformrotateCluster, i : Int, v : Double) -> ImagetransformrotateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCluster::sum(self : ImagetransformrotateCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateCluster::mean(self : ImagetransformrotateCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateCluster::scale(self : ImagetransformrotateCluster, f : Double) -> ImagetransformrotateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCluster::add(self : ImagetransformrotateCluster, other : ImagetransformrotateCluster) -> ImagetransformrotateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateCluster::copy(self : ImagetransformrotateCluster) -> ImagetransformrotateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCluster::fill(self : ImagetransformrotateCluster, v : Double) -> ImagetransformrotateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCluster::min(self : ImagetransformrotateCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateCluster::max(self : ImagetransformrotateCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateCluster::to_string(self : ImagetransformrotateCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_model_make(size : Int) -> ImagetransformrotateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateModel::len(self : ImagetransformrotateModel) -> Int { self.size }

pub fn ImagetransformrotateModel::get(self : ImagetransformrotateModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateModel::set(self : ImagetransformrotateModel, i : Int, v : Double) -> ImagetransformrotateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateModel::sum(self : ImagetransformrotateModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateModel::mean(self : ImagetransformrotateModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateModel::scale(self : ImagetransformrotateModel, f : Double) -> ImagetransformrotateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateModel::add(self : ImagetransformrotateModel, other : ImagetransformrotateModel) -> ImagetransformrotateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateModel::copy(self : ImagetransformrotateModel) -> ImagetransformrotateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateModel::fill(self : ImagetransformrotateModel, v : Double) -> ImagetransformrotateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateModel::min(self : ImagetransformrotateModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateModel::max(self : ImagetransformrotateModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateModel::to_string(self : ImagetransformrotateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_layer_make(size : Int) -> ImagetransformrotateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateLayer::len(self : ImagetransformrotateLayer) -> Int { self.size }

pub fn ImagetransformrotateLayer::get(self : ImagetransformrotateLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateLayer::set(self : ImagetransformrotateLayer, i : Int, v : Double) -> ImagetransformrotateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateLayer::sum(self : ImagetransformrotateLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateLayer::mean(self : ImagetransformrotateLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateLayer::scale(self : ImagetransformrotateLayer, f : Double) -> ImagetransformrotateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateLayer::add(self : ImagetransformrotateLayer, other : ImagetransformrotateLayer) -> ImagetransformrotateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateLayer::copy(self : ImagetransformrotateLayer) -> ImagetransformrotateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateLayer::fill(self : ImagetransformrotateLayer, v : Double) -> ImagetransformrotateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateLayer::min(self : ImagetransformrotateLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateLayer::max(self : ImagetransformrotateLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateLayer::to_string(self : ImagetransformrotateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_buffer_make(size : Int) -> ImagetransformrotateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateBuffer::len(self : ImagetransformrotateBuffer) -> Int { self.size }

pub fn ImagetransformrotateBuffer::get(self : ImagetransformrotateBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateBuffer::set(self : ImagetransformrotateBuffer, i : Int, v : Double) -> ImagetransformrotateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateBuffer::sum(self : ImagetransformrotateBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateBuffer::mean(self : ImagetransformrotateBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateBuffer::scale(self : ImagetransformrotateBuffer, f : Double) -> ImagetransformrotateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateBuffer::add(self : ImagetransformrotateBuffer, other : ImagetransformrotateBuffer) -> ImagetransformrotateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateBuffer::copy(self : ImagetransformrotateBuffer) -> ImagetransformrotateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateBuffer::fill(self : ImagetransformrotateBuffer, v : Double) -> ImagetransformrotateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateBuffer::min(self : ImagetransformrotateBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateBuffer::max(self : ImagetransformrotateBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateBuffer::to_string(self : ImagetransformrotateBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_cursor_make(size : Int) -> ImagetransformrotateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateCursor::len(self : ImagetransformrotateCursor) -> Int { self.size }

pub fn ImagetransformrotateCursor::get(self : ImagetransformrotateCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateCursor::set(self : ImagetransformrotateCursor, i : Int, v : Double) -> ImagetransformrotateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCursor::sum(self : ImagetransformrotateCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateCursor::mean(self : ImagetransformrotateCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateCursor::scale(self : ImagetransformrotateCursor, f : Double) -> ImagetransformrotateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCursor::add(self : ImagetransformrotateCursor, other : ImagetransformrotateCursor) -> ImagetransformrotateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateCursor::copy(self : ImagetransformrotateCursor) -> ImagetransformrotateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCursor::fill(self : ImagetransformrotateCursor, v : Double) -> ImagetransformrotateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateCursor::min(self : ImagetransformrotateCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateCursor::max(self : ImagetransformrotateCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateCursor::to_string(self : ImagetransformrotateCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_view_make(size : Int) -> ImagetransformrotateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateView::len(self : ImagetransformrotateView) -> Int { self.size }

pub fn ImagetransformrotateView::get(self : ImagetransformrotateView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateView::set(self : ImagetransformrotateView, i : Int, v : Double) -> ImagetransformrotateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateView::sum(self : ImagetransformrotateView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateView::mean(self : ImagetransformrotateView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateView::scale(self : ImagetransformrotateView, f : Double) -> ImagetransformrotateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateView::add(self : ImagetransformrotateView, other : ImagetransformrotateView) -> ImagetransformrotateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateView::copy(self : ImagetransformrotateView) -> ImagetransformrotateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateView::fill(self : ImagetransformrotateView, v : Double) -> ImagetransformrotateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateView::min(self : ImagetransformrotateView) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateView::max(self : ImagetransformrotateView) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateView::to_string(self : ImagetransformrotateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_range_make(size : Int) -> ImagetransformrotateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateRange::len(self : ImagetransformrotateRange) -> Int { self.size }

pub fn ImagetransformrotateRange::get(self : ImagetransformrotateRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateRange::set(self : ImagetransformrotateRange, i : Int, v : Double) -> ImagetransformrotateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateRange::sum(self : ImagetransformrotateRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateRange::mean(self : ImagetransformrotateRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateRange::scale(self : ImagetransformrotateRange, f : Double) -> ImagetransformrotateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateRange::add(self : ImagetransformrotateRange, other : ImagetransformrotateRange) -> ImagetransformrotateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateRange::copy(self : ImagetransformrotateRange) -> ImagetransformrotateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateRange::fill(self : ImagetransformrotateRange, v : Double) -> ImagetransformrotateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateRange::min(self : ImagetransformrotateRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateRange::max(self : ImagetransformrotateRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateRange::to_string(self : ImagetransformrotateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_slice_make(size : Int) -> ImagetransformrotateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformrotateSlice::len(self : ImagetransformrotateSlice) -> Int { self.size }

pub fn ImagetransformrotateSlice::get(self : ImagetransformrotateSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformrotateSlice::set(self : ImagetransformrotateSlice, i : Int, v : Double) -> ImagetransformrotateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateSlice::sum(self : ImagetransformrotateSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformrotateSlice::mean(self : ImagetransformrotateSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformrotateSlice::scale(self : ImagetransformrotateSlice, f : Double) -> ImagetransformrotateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateSlice::add(self : ImagetransformrotateSlice, other : ImagetransformrotateSlice) -> ImagetransformrotateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformrotateSlice::copy(self : ImagetransformrotateSlice) -> ImagetransformrotateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateSlice::fill(self : ImagetransformrotateSlice, v : Double) -> ImagetransformrotateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformrotateSlice::min(self : ImagetransformrotateSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformrotateSlice::max(self : ImagetransformrotateSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformrotateSlice::to_string(self : ImagetransformrotateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

