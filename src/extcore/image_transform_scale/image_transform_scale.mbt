///===
/// extcore/image_transform_scale

pub(all) struct ImagetransformscalePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_scale_make_point(x : Double, y : Double) -> ImagetransformscalePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_scale_make_point3(x : Double, y : Double, z : Double) -> ImagetransformscalePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformscalePoint::x(self : ImagetransformscalePoint) -> Double { self.x }

pub fn ImagetransformscalePoint::y(self : ImagetransformscalePoint) -> Double { self.y }

pub fn ImagetransformscalePoint::z(self : ImagetransformscalePoint) -> Double { self.z }

pub fn ImagetransformscalePoint::label(self : ImagetransformscalePoint) -> Int { self.label }

pub fn ImagetransformscalePoint::dist(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformscalePoint::add(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformscalePoint::sub(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformscalePoint::scale(self : ImagetransformscalePoint, s : Double) -> ImagetransformscalePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformscalePoint::dot(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformscalePoint::cross(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformscalePoint::norm(self : ImagetransformscalePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformscalePoint::normalize(self : ImagetransformscalePoint) -> ImagetransformscalePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformscalePoint::negate(self : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformscalePoint::mid(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformscalePoint::lerp(self : ImagetransformscalePoint, other : ImagetransformscalePoint, t : Double) -> ImagetransformscalePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformscalePoint::to_string(self : ImagetransformscalePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformscaleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_scale_make_series(vals : Array[Double], name : String) -> ImagetransformscaleSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformscaleSeries::len(self : ImagetransformscaleSeries) -> Int { self.vals.length() }

pub fn ImagetransformscaleSeries::sum(self : ImagetransformscaleSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformscaleSeries::mean(self : ImagetransformscaleSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformscaleSeries::min(self : ImagetransformscaleSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformscaleSeries::max(self : ImagetransformscaleSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformscaleSeries::range(self : ImagetransformscaleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformscaleSeries::variance(self : ImagetransformscaleSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformscaleSeries::std(self : ImagetransformscaleSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformscaleSeries::median(self : ImagetransformscaleSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformscaleSeries::scale(self : ImagetransformscaleSeries, f : Double) -> ImagetransformscaleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformscaleSeries::add(self : ImagetransformscaleSeries, other : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformscaleSeries::sub(self : ImagetransformscaleSeries, other : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformscaleSeries::normalize(self : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformscaleSeries::cumsum(self : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformscaleSeries::to_string(self : ImagetransformscaleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformscaleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_scale_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformscaleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_scale_matrix_identity(n : Int) -> ImagetransformscaleMatrix {
  let m = image_transform_scale_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformscaleMatrix::get(self : ImagetransformscaleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformscaleMatrix::transpose(self : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  let result = image_transform_scale_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformscaleMatrix::add(self : ImagetransformscaleMatrix, other : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_scale_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformscaleMatrix::scale(self : ImagetransformscaleMatrix, s : Double) -> ImagetransformscaleMatrix {
  let result = image_transform_scale_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformscaleMatrix::multiply(self : ImagetransformscaleMatrix, other : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  if self.cols != other.rows { return image_transform_scale_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_scale_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagetransformscaleMatrix::trace(self : ImagetransformscaleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformscaleMatrix::det(self : ImagetransformscaleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformscaleMatrix::norm(self : ImagetransformscaleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformscaleMatrix::to_string(self : ImagetransformscaleMatrix) -> String {
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

pub(all) struct ImagetransformscaleVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_scale_make_vector(comps : Array[Double]) -> ImagetransformscaleVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_scale_vector_zero(dim : Int) -> ImagetransformscaleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformscaleVector::add(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformscaleVector::sub(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformscaleVector::scale(self : ImagetransformscaleVector, s : Double) -> ImagetransformscaleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformscaleVector::dot(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformscaleVector::norm(self : ImagetransformscaleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformscaleVector::normalize(self : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformscaleVector::dist(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformscaleVector::to_string(self : ImagetransformscaleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformscaleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_frame_make(size : Int) -> ImagetransformscaleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleFrame::len(self : ImagetransformscaleFrame) -> Int { self.size }

pub fn ImagetransformscaleFrame::get(self : ImagetransformscaleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleFrame::set(self : ImagetransformscaleFrame, i : Int, v : Double) -> ImagetransformscaleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleFrame::sum(self : ImagetransformscaleFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleFrame::mean(self : ImagetransformscaleFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleFrame::scale(self : ImagetransformscaleFrame, f : Double) -> ImagetransformscaleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleFrame::add(self : ImagetransformscaleFrame, other : ImagetransformscaleFrame) -> ImagetransformscaleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleFrame::copy(self : ImagetransformscaleFrame) -> ImagetransformscaleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleFrame::fill(self : ImagetransformscaleFrame, v : Double) -> ImagetransformscaleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleFrame::min(self : ImagetransformscaleFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleFrame::max(self : ImagetransformscaleFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleFrame::to_string(self : ImagetransformscaleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_table_make(size : Int) -> ImagetransformscaleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleTable::len(self : ImagetransformscaleTable) -> Int { self.size }

pub fn ImagetransformscaleTable::get(self : ImagetransformscaleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleTable::set(self : ImagetransformscaleTable, i : Int, v : Double) -> ImagetransformscaleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleTable::sum(self : ImagetransformscaleTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleTable::mean(self : ImagetransformscaleTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleTable::scale(self : ImagetransformscaleTable, f : Double) -> ImagetransformscaleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleTable::add(self : ImagetransformscaleTable, other : ImagetransformscaleTable) -> ImagetransformscaleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleTable::copy(self : ImagetransformscaleTable) -> ImagetransformscaleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleTable::fill(self : ImagetransformscaleTable, v : Double) -> ImagetransformscaleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleTable::min(self : ImagetransformscaleTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleTable::max(self : ImagetransformscaleTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleTable::to_string(self : ImagetransformscaleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_graphn_make(size : Int) -> ImagetransformscaleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleGraphN::len(self : ImagetransformscaleGraphN) -> Int { self.size }

pub fn ImagetransformscaleGraphN::get(self : ImagetransformscaleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleGraphN::set(self : ImagetransformscaleGraphN, i : Int, v : Double) -> ImagetransformscaleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleGraphN::sum(self : ImagetransformscaleGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleGraphN::mean(self : ImagetransformscaleGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleGraphN::scale(self : ImagetransformscaleGraphN, f : Double) -> ImagetransformscaleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleGraphN::add(self : ImagetransformscaleGraphN, other : ImagetransformscaleGraphN) -> ImagetransformscaleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleGraphN::copy(self : ImagetransformscaleGraphN) -> ImagetransformscaleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleGraphN::fill(self : ImagetransformscaleGraphN, v : Double) -> ImagetransformscaleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleGraphN::min(self : ImagetransformscaleGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleGraphN::max(self : ImagetransformscaleGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleGraphN::to_string(self : ImagetransformscaleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_node_make(size : Int) -> ImagetransformscaleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleNode::len(self : ImagetransformscaleNode) -> Int { self.size }

pub fn ImagetransformscaleNode::get(self : ImagetransformscaleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleNode::set(self : ImagetransformscaleNode, i : Int, v : Double) -> ImagetransformscaleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleNode::sum(self : ImagetransformscaleNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleNode::mean(self : ImagetransformscaleNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleNode::scale(self : ImagetransformscaleNode, f : Double) -> ImagetransformscaleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleNode::add(self : ImagetransformscaleNode, other : ImagetransformscaleNode) -> ImagetransformscaleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleNode::copy(self : ImagetransformscaleNode) -> ImagetransformscaleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleNode::fill(self : ImagetransformscaleNode, v : Double) -> ImagetransformscaleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleNode::min(self : ImagetransformscaleNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleNode::max(self : ImagetransformscaleNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleNode::to_string(self : ImagetransformscaleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_edge_make(size : Int) -> ImagetransformscaleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleEdge::len(self : ImagetransformscaleEdge) -> Int { self.size }

pub fn ImagetransformscaleEdge::get(self : ImagetransformscaleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleEdge::set(self : ImagetransformscaleEdge, i : Int, v : Double) -> ImagetransformscaleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleEdge::sum(self : ImagetransformscaleEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleEdge::mean(self : ImagetransformscaleEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleEdge::scale(self : ImagetransformscaleEdge, f : Double) -> ImagetransformscaleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleEdge::add(self : ImagetransformscaleEdge, other : ImagetransformscaleEdge) -> ImagetransformscaleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleEdge::copy(self : ImagetransformscaleEdge) -> ImagetransformscaleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleEdge::fill(self : ImagetransformscaleEdge, v : Double) -> ImagetransformscaleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleEdge::min(self : ImagetransformscaleEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleEdge::max(self : ImagetransformscaleEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleEdge::to_string(self : ImagetransformscaleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscalePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_path_make(size : Int) -> ImagetransformscalePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscalePath::len(self : ImagetransformscalePath) -> Int { self.size }

pub fn ImagetransformscalePath::get(self : ImagetransformscalePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscalePath::set(self : ImagetransformscalePath, i : Int, v : Double) -> ImagetransformscalePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscalePath::sum(self : ImagetransformscalePath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscalePath::mean(self : ImagetransformscalePath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscalePath::scale(self : ImagetransformscalePath, f : Double) -> ImagetransformscalePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscalePath::add(self : ImagetransformscalePath, other : ImagetransformscalePath) -> ImagetransformscalePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscalePath::copy(self : ImagetransformscalePath) -> ImagetransformscalePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscalePath::fill(self : ImagetransformscalePath, v : Double) -> ImagetransformscalePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscalePath::min(self : ImagetransformscalePath) -> Double { @_common.min(self.data) }

pub fn ImagetransformscalePath::max(self : ImagetransformscalePath) -> Double { @_common.max(self.data) }

pub fn ImagetransformscalePath::to_string(self : ImagetransformscalePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_cluster_make(size : Int) -> ImagetransformscaleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleCluster::len(self : ImagetransformscaleCluster) -> Int { self.size }

pub fn ImagetransformscaleCluster::get(self : ImagetransformscaleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleCluster::set(self : ImagetransformscaleCluster, i : Int, v : Double) -> ImagetransformscaleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCluster::sum(self : ImagetransformscaleCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleCluster::mean(self : ImagetransformscaleCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleCluster::scale(self : ImagetransformscaleCluster, f : Double) -> ImagetransformscaleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCluster::add(self : ImagetransformscaleCluster, other : ImagetransformscaleCluster) -> ImagetransformscaleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleCluster::copy(self : ImagetransformscaleCluster) -> ImagetransformscaleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCluster::fill(self : ImagetransformscaleCluster, v : Double) -> ImagetransformscaleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCluster::min(self : ImagetransformscaleCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleCluster::max(self : ImagetransformscaleCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleCluster::to_string(self : ImagetransformscaleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_model_make(size : Int) -> ImagetransformscaleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleModel::len(self : ImagetransformscaleModel) -> Int { self.size }

pub fn ImagetransformscaleModel::get(self : ImagetransformscaleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleModel::set(self : ImagetransformscaleModel, i : Int, v : Double) -> ImagetransformscaleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleModel::sum(self : ImagetransformscaleModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleModel::mean(self : ImagetransformscaleModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleModel::scale(self : ImagetransformscaleModel, f : Double) -> ImagetransformscaleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleModel::add(self : ImagetransformscaleModel, other : ImagetransformscaleModel) -> ImagetransformscaleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleModel::copy(self : ImagetransformscaleModel) -> ImagetransformscaleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleModel::fill(self : ImagetransformscaleModel, v : Double) -> ImagetransformscaleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleModel::min(self : ImagetransformscaleModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleModel::max(self : ImagetransformscaleModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleModel::to_string(self : ImagetransformscaleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_layer_make(size : Int) -> ImagetransformscaleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleLayer::len(self : ImagetransformscaleLayer) -> Int { self.size }

pub fn ImagetransformscaleLayer::get(self : ImagetransformscaleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleLayer::set(self : ImagetransformscaleLayer, i : Int, v : Double) -> ImagetransformscaleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleLayer::sum(self : ImagetransformscaleLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleLayer::mean(self : ImagetransformscaleLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleLayer::scale(self : ImagetransformscaleLayer, f : Double) -> ImagetransformscaleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleLayer::add(self : ImagetransformscaleLayer, other : ImagetransformscaleLayer) -> ImagetransformscaleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleLayer::copy(self : ImagetransformscaleLayer) -> ImagetransformscaleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleLayer::fill(self : ImagetransformscaleLayer, v : Double) -> ImagetransformscaleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleLayer::min(self : ImagetransformscaleLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleLayer::max(self : ImagetransformscaleLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleLayer::to_string(self : ImagetransformscaleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_buffer_make(size : Int) -> ImagetransformscaleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleBuffer::len(self : ImagetransformscaleBuffer) -> Int { self.size }

pub fn ImagetransformscaleBuffer::get(self : ImagetransformscaleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleBuffer::set(self : ImagetransformscaleBuffer, i : Int, v : Double) -> ImagetransformscaleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleBuffer::sum(self : ImagetransformscaleBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleBuffer::mean(self : ImagetransformscaleBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleBuffer::scale(self : ImagetransformscaleBuffer, f : Double) -> ImagetransformscaleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleBuffer::add(self : ImagetransformscaleBuffer, other : ImagetransformscaleBuffer) -> ImagetransformscaleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleBuffer::copy(self : ImagetransformscaleBuffer) -> ImagetransformscaleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleBuffer::fill(self : ImagetransformscaleBuffer, v : Double) -> ImagetransformscaleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleBuffer::min(self : ImagetransformscaleBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleBuffer::max(self : ImagetransformscaleBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleBuffer::to_string(self : ImagetransformscaleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_cursor_make(size : Int) -> ImagetransformscaleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleCursor::len(self : ImagetransformscaleCursor) -> Int { self.size }

pub fn ImagetransformscaleCursor::get(self : ImagetransformscaleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleCursor::set(self : ImagetransformscaleCursor, i : Int, v : Double) -> ImagetransformscaleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCursor::sum(self : ImagetransformscaleCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleCursor::mean(self : ImagetransformscaleCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleCursor::scale(self : ImagetransformscaleCursor, f : Double) -> ImagetransformscaleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCursor::add(self : ImagetransformscaleCursor, other : ImagetransformscaleCursor) -> ImagetransformscaleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleCursor::copy(self : ImagetransformscaleCursor) -> ImagetransformscaleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCursor::fill(self : ImagetransformscaleCursor, v : Double) -> ImagetransformscaleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleCursor::min(self : ImagetransformscaleCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleCursor::max(self : ImagetransformscaleCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleCursor::to_string(self : ImagetransformscaleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_view_make(size : Int) -> ImagetransformscaleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleView::len(self : ImagetransformscaleView) -> Int { self.size }

pub fn ImagetransformscaleView::get(self : ImagetransformscaleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleView::set(self : ImagetransformscaleView, i : Int, v : Double) -> ImagetransformscaleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleView::sum(self : ImagetransformscaleView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleView::mean(self : ImagetransformscaleView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleView::scale(self : ImagetransformscaleView, f : Double) -> ImagetransformscaleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleView::add(self : ImagetransformscaleView, other : ImagetransformscaleView) -> ImagetransformscaleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleView::copy(self : ImagetransformscaleView) -> ImagetransformscaleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleView::fill(self : ImagetransformscaleView, v : Double) -> ImagetransformscaleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleView::min(self : ImagetransformscaleView) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleView::max(self : ImagetransformscaleView) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleView::to_string(self : ImagetransformscaleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_range_make(size : Int) -> ImagetransformscaleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleRange::len(self : ImagetransformscaleRange) -> Int { self.size }

pub fn ImagetransformscaleRange::get(self : ImagetransformscaleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleRange::set(self : ImagetransformscaleRange, i : Int, v : Double) -> ImagetransformscaleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleRange::sum(self : ImagetransformscaleRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleRange::mean(self : ImagetransformscaleRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleRange::scale(self : ImagetransformscaleRange, f : Double) -> ImagetransformscaleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleRange::add(self : ImagetransformscaleRange, other : ImagetransformscaleRange) -> ImagetransformscaleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleRange::copy(self : ImagetransformscaleRange) -> ImagetransformscaleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleRange::fill(self : ImagetransformscaleRange, v : Double) -> ImagetransformscaleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleRange::min(self : ImagetransformscaleRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleRange::max(self : ImagetransformscaleRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleRange::to_string(self : ImagetransformscaleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_slice_make(size : Int) -> ImagetransformscaleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformscaleSlice::len(self : ImagetransformscaleSlice) -> Int { self.size }

pub fn ImagetransformscaleSlice::get(self : ImagetransformscaleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformscaleSlice::set(self : ImagetransformscaleSlice, i : Int, v : Double) -> ImagetransformscaleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleSlice::sum(self : ImagetransformscaleSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformscaleSlice::mean(self : ImagetransformscaleSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformscaleSlice::scale(self : ImagetransformscaleSlice, f : Double) -> ImagetransformscaleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleSlice::add(self : ImagetransformscaleSlice, other : ImagetransformscaleSlice) -> ImagetransformscaleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformscaleSlice::copy(self : ImagetransformscaleSlice) -> ImagetransformscaleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleSlice::fill(self : ImagetransformscaleSlice, v : Double) -> ImagetransformscaleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformscaleSlice::min(self : ImagetransformscaleSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformscaleSlice::max(self : ImagetransformscaleSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformscaleSlice::to_string(self : ImagetransformscaleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

