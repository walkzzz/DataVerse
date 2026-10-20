///===
/// extcore/image_transform_warp

pub(all) struct ImagetransformwarpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_warp_make_point(x : Double, y : Double) -> ImagetransformwarpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_warp_make_point3(x : Double, y : Double, z : Double) -> ImagetransformwarpPoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformwarpPoint::x(self : ImagetransformwarpPoint) -> Double { self.x }

pub fn ImagetransformwarpPoint::y(self : ImagetransformwarpPoint) -> Double { self.y }

pub fn ImagetransformwarpPoint::z(self : ImagetransformwarpPoint) -> Double { self.z }

pub fn ImagetransformwarpPoint::label(self : ImagetransformwarpPoint) -> Int { self.label }

pub fn ImagetransformwarpPoint::dist(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformwarpPoint::add(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformwarpPoint::sub(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformwarpPoint::scale(self : ImagetransformwarpPoint, s : Double) -> ImagetransformwarpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformwarpPoint::dot(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformwarpPoint::cross(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformwarpPoint::norm(self : ImagetransformwarpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformwarpPoint::normalize(self : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformwarpPoint::negate(self : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformwarpPoint::mid(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformwarpPoint::lerp(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint, t : Double) -> ImagetransformwarpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformwarpPoint::to_string(self : ImagetransformwarpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformwarpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_warp_make_series(vals : Array[Double], name : String) -> ImagetransformwarpSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformwarpSeries::len(self : ImagetransformwarpSeries) -> Int { self.vals.length() }

pub fn ImagetransformwarpSeries::sum(self : ImagetransformwarpSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformwarpSeries::mean(self : ImagetransformwarpSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformwarpSeries::min(self : ImagetransformwarpSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformwarpSeries::max(self : ImagetransformwarpSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformwarpSeries::range(self : ImagetransformwarpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformwarpSeries::variance(self : ImagetransformwarpSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformwarpSeries::std(self : ImagetransformwarpSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformwarpSeries::median(self : ImagetransformwarpSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformwarpSeries::scale(self : ImagetransformwarpSeries, f : Double) -> ImagetransformwarpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformwarpSeries::add(self : ImagetransformwarpSeries, other : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformwarpSeries::sub(self : ImagetransformwarpSeries, other : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformwarpSeries::normalize(self : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformwarpSeries::cumsum(self : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformwarpSeries::to_string(self : ImagetransformwarpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformwarpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_warp_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformwarpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_warp_matrix_identity(n : Int) -> ImagetransformwarpMatrix {
  let m = image_transform_warp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformwarpMatrix::get(self : ImagetransformwarpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformwarpMatrix::transpose(self : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformwarpMatrix::add(self : ImagetransformwarpMatrix, other : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_warp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformwarpMatrix::scale(self : ImagetransformwarpMatrix, s : Double) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformwarpMatrix::multiply(self : ImagetransformwarpMatrix, other : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if self.cols != other.rows { return image_transform_warp_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_warp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagetransformwarpMatrix::trace(self : ImagetransformwarpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformwarpMatrix::det(self : ImagetransformwarpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformwarpMatrix::norm(self : ImagetransformwarpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformwarpMatrix::to_string(self : ImagetransformwarpMatrix) -> String {
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

pub(all) struct ImagetransformwarpVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_warp_make_vector(comps : Array[Double]) -> ImagetransformwarpVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_warp_vector_zero(dim : Int) -> ImagetransformwarpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformwarpVector::add(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformwarpVector::sub(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformwarpVector::scale(self : ImagetransformwarpVector, s : Double) -> ImagetransformwarpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformwarpVector::dot(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformwarpVector::norm(self : ImagetransformwarpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformwarpVector::normalize(self : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformwarpVector::dist(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformwarpVector::to_string(self : ImagetransformwarpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformwarpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_frame_make(size : Int) -> ImagetransformwarpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpFrame::len(self : ImagetransformwarpFrame) -> Int { self.size }

pub fn ImagetransformwarpFrame::get(self : ImagetransformwarpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpFrame::set(self : ImagetransformwarpFrame, i : Int, v : Double) -> ImagetransformwarpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpFrame::sum(self : ImagetransformwarpFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpFrame::mean(self : ImagetransformwarpFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpFrame::scale(self : ImagetransformwarpFrame, f : Double) -> ImagetransformwarpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpFrame::add(self : ImagetransformwarpFrame, other : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpFrame::copy(self : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpFrame::fill(self : ImagetransformwarpFrame, v : Double) -> ImagetransformwarpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpFrame::min(self : ImagetransformwarpFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpFrame::max(self : ImagetransformwarpFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpFrame::to_string(self : ImagetransformwarpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_table_make(size : Int) -> ImagetransformwarpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpTable::len(self : ImagetransformwarpTable) -> Int { self.size }

pub fn ImagetransformwarpTable::get(self : ImagetransformwarpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpTable::set(self : ImagetransformwarpTable, i : Int, v : Double) -> ImagetransformwarpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpTable::sum(self : ImagetransformwarpTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpTable::mean(self : ImagetransformwarpTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpTable::scale(self : ImagetransformwarpTable, f : Double) -> ImagetransformwarpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpTable::add(self : ImagetransformwarpTable, other : ImagetransformwarpTable) -> ImagetransformwarpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpTable::copy(self : ImagetransformwarpTable) -> ImagetransformwarpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpTable::fill(self : ImagetransformwarpTable, v : Double) -> ImagetransformwarpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpTable::min(self : ImagetransformwarpTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpTable::max(self : ImagetransformwarpTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpTable::to_string(self : ImagetransformwarpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_graphn_make(size : Int) -> ImagetransformwarpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpGraphN::len(self : ImagetransformwarpGraphN) -> Int { self.size }

pub fn ImagetransformwarpGraphN::get(self : ImagetransformwarpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpGraphN::set(self : ImagetransformwarpGraphN, i : Int, v : Double) -> ImagetransformwarpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpGraphN::sum(self : ImagetransformwarpGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpGraphN::mean(self : ImagetransformwarpGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpGraphN::scale(self : ImagetransformwarpGraphN, f : Double) -> ImagetransformwarpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpGraphN::add(self : ImagetransformwarpGraphN, other : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpGraphN::copy(self : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpGraphN::fill(self : ImagetransformwarpGraphN, v : Double) -> ImagetransformwarpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpGraphN::min(self : ImagetransformwarpGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpGraphN::max(self : ImagetransformwarpGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpGraphN::to_string(self : ImagetransformwarpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_node_make(size : Int) -> ImagetransformwarpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpNode::len(self : ImagetransformwarpNode) -> Int { self.size }

pub fn ImagetransformwarpNode::get(self : ImagetransformwarpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpNode::set(self : ImagetransformwarpNode, i : Int, v : Double) -> ImagetransformwarpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpNode::sum(self : ImagetransformwarpNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpNode::mean(self : ImagetransformwarpNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpNode::scale(self : ImagetransformwarpNode, f : Double) -> ImagetransformwarpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpNode::add(self : ImagetransformwarpNode, other : ImagetransformwarpNode) -> ImagetransformwarpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpNode::copy(self : ImagetransformwarpNode) -> ImagetransformwarpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpNode::fill(self : ImagetransformwarpNode, v : Double) -> ImagetransformwarpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpNode::min(self : ImagetransformwarpNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpNode::max(self : ImagetransformwarpNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpNode::to_string(self : ImagetransformwarpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_edge_make(size : Int) -> ImagetransformwarpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpEdge::len(self : ImagetransformwarpEdge) -> Int { self.size }

pub fn ImagetransformwarpEdge::get(self : ImagetransformwarpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpEdge::set(self : ImagetransformwarpEdge, i : Int, v : Double) -> ImagetransformwarpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpEdge::sum(self : ImagetransformwarpEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpEdge::mean(self : ImagetransformwarpEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpEdge::scale(self : ImagetransformwarpEdge, f : Double) -> ImagetransformwarpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpEdge::add(self : ImagetransformwarpEdge, other : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpEdge::copy(self : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpEdge::fill(self : ImagetransformwarpEdge, v : Double) -> ImagetransformwarpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpEdge::min(self : ImagetransformwarpEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpEdge::max(self : ImagetransformwarpEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpEdge::to_string(self : ImagetransformwarpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_path_make(size : Int) -> ImagetransformwarpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpPath::len(self : ImagetransformwarpPath) -> Int { self.size }

pub fn ImagetransformwarpPath::get(self : ImagetransformwarpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpPath::set(self : ImagetransformwarpPath, i : Int, v : Double) -> ImagetransformwarpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpPath::sum(self : ImagetransformwarpPath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpPath::mean(self : ImagetransformwarpPath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpPath::scale(self : ImagetransformwarpPath, f : Double) -> ImagetransformwarpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpPath::add(self : ImagetransformwarpPath, other : ImagetransformwarpPath) -> ImagetransformwarpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpPath::copy(self : ImagetransformwarpPath) -> ImagetransformwarpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpPath::fill(self : ImagetransformwarpPath, v : Double) -> ImagetransformwarpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpPath::min(self : ImagetransformwarpPath) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpPath::max(self : ImagetransformwarpPath) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpPath::to_string(self : ImagetransformwarpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cluster_make(size : Int) -> ImagetransformwarpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpCluster::len(self : ImagetransformwarpCluster) -> Int { self.size }

pub fn ImagetransformwarpCluster::get(self : ImagetransformwarpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpCluster::set(self : ImagetransformwarpCluster, i : Int, v : Double) -> ImagetransformwarpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCluster::sum(self : ImagetransformwarpCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpCluster::mean(self : ImagetransformwarpCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpCluster::scale(self : ImagetransformwarpCluster, f : Double) -> ImagetransformwarpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCluster::add(self : ImagetransformwarpCluster, other : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpCluster::copy(self : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCluster::fill(self : ImagetransformwarpCluster, v : Double) -> ImagetransformwarpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCluster::min(self : ImagetransformwarpCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpCluster::max(self : ImagetransformwarpCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpCluster::to_string(self : ImagetransformwarpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_model_make(size : Int) -> ImagetransformwarpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpModel::len(self : ImagetransformwarpModel) -> Int { self.size }

pub fn ImagetransformwarpModel::get(self : ImagetransformwarpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpModel::set(self : ImagetransformwarpModel, i : Int, v : Double) -> ImagetransformwarpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpModel::sum(self : ImagetransformwarpModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpModel::mean(self : ImagetransformwarpModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpModel::scale(self : ImagetransformwarpModel, f : Double) -> ImagetransformwarpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpModel::add(self : ImagetransformwarpModel, other : ImagetransformwarpModel) -> ImagetransformwarpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpModel::copy(self : ImagetransformwarpModel) -> ImagetransformwarpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpModel::fill(self : ImagetransformwarpModel, v : Double) -> ImagetransformwarpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpModel::min(self : ImagetransformwarpModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpModel::max(self : ImagetransformwarpModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpModel::to_string(self : ImagetransformwarpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_layer_make(size : Int) -> ImagetransformwarpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpLayer::len(self : ImagetransformwarpLayer) -> Int { self.size }

pub fn ImagetransformwarpLayer::get(self : ImagetransformwarpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpLayer::set(self : ImagetransformwarpLayer, i : Int, v : Double) -> ImagetransformwarpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpLayer::sum(self : ImagetransformwarpLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpLayer::mean(self : ImagetransformwarpLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpLayer::scale(self : ImagetransformwarpLayer, f : Double) -> ImagetransformwarpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpLayer::add(self : ImagetransformwarpLayer, other : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpLayer::copy(self : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpLayer::fill(self : ImagetransformwarpLayer, v : Double) -> ImagetransformwarpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpLayer::min(self : ImagetransformwarpLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpLayer::max(self : ImagetransformwarpLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpLayer::to_string(self : ImagetransformwarpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_buffer_make(size : Int) -> ImagetransformwarpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpBuffer::len(self : ImagetransformwarpBuffer) -> Int { self.size }

pub fn ImagetransformwarpBuffer::get(self : ImagetransformwarpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpBuffer::set(self : ImagetransformwarpBuffer, i : Int, v : Double) -> ImagetransformwarpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpBuffer::sum(self : ImagetransformwarpBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpBuffer::mean(self : ImagetransformwarpBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpBuffer::scale(self : ImagetransformwarpBuffer, f : Double) -> ImagetransformwarpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpBuffer::add(self : ImagetransformwarpBuffer, other : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpBuffer::copy(self : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpBuffer::fill(self : ImagetransformwarpBuffer, v : Double) -> ImagetransformwarpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpBuffer::min(self : ImagetransformwarpBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpBuffer::max(self : ImagetransformwarpBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpBuffer::to_string(self : ImagetransformwarpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cursor_make(size : Int) -> ImagetransformwarpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpCursor::len(self : ImagetransformwarpCursor) -> Int { self.size }

pub fn ImagetransformwarpCursor::get(self : ImagetransformwarpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpCursor::set(self : ImagetransformwarpCursor, i : Int, v : Double) -> ImagetransformwarpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCursor::sum(self : ImagetransformwarpCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpCursor::mean(self : ImagetransformwarpCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpCursor::scale(self : ImagetransformwarpCursor, f : Double) -> ImagetransformwarpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCursor::add(self : ImagetransformwarpCursor, other : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpCursor::copy(self : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCursor::fill(self : ImagetransformwarpCursor, v : Double) -> ImagetransformwarpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpCursor::min(self : ImagetransformwarpCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpCursor::max(self : ImagetransformwarpCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpCursor::to_string(self : ImagetransformwarpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_view_make(size : Int) -> ImagetransformwarpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpView::len(self : ImagetransformwarpView) -> Int { self.size }

pub fn ImagetransformwarpView::get(self : ImagetransformwarpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpView::set(self : ImagetransformwarpView, i : Int, v : Double) -> ImagetransformwarpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpView::sum(self : ImagetransformwarpView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpView::mean(self : ImagetransformwarpView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpView::scale(self : ImagetransformwarpView, f : Double) -> ImagetransformwarpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpView::add(self : ImagetransformwarpView, other : ImagetransformwarpView) -> ImagetransformwarpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpView::copy(self : ImagetransformwarpView) -> ImagetransformwarpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpView::fill(self : ImagetransformwarpView, v : Double) -> ImagetransformwarpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpView::min(self : ImagetransformwarpView) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpView::max(self : ImagetransformwarpView) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpView::to_string(self : ImagetransformwarpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_range_make(size : Int) -> ImagetransformwarpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpRange::len(self : ImagetransformwarpRange) -> Int { self.size }

pub fn ImagetransformwarpRange::get(self : ImagetransformwarpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpRange::set(self : ImagetransformwarpRange, i : Int, v : Double) -> ImagetransformwarpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpRange::sum(self : ImagetransformwarpRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpRange::mean(self : ImagetransformwarpRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpRange::scale(self : ImagetransformwarpRange, f : Double) -> ImagetransformwarpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpRange::add(self : ImagetransformwarpRange, other : ImagetransformwarpRange) -> ImagetransformwarpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpRange::copy(self : ImagetransformwarpRange) -> ImagetransformwarpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpRange::fill(self : ImagetransformwarpRange, v : Double) -> ImagetransformwarpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpRange::min(self : ImagetransformwarpRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpRange::max(self : ImagetransformwarpRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpRange::to_string(self : ImagetransformwarpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_slice_make(size : Int) -> ImagetransformwarpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformwarpSlice::len(self : ImagetransformwarpSlice) -> Int { self.size }

pub fn ImagetransformwarpSlice::get(self : ImagetransformwarpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformwarpSlice::set(self : ImagetransformwarpSlice, i : Int, v : Double) -> ImagetransformwarpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpSlice::sum(self : ImagetransformwarpSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformwarpSlice::mean(self : ImagetransformwarpSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformwarpSlice::scale(self : ImagetransformwarpSlice, f : Double) -> ImagetransformwarpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpSlice::add(self : ImagetransformwarpSlice, other : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformwarpSlice::copy(self : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpSlice::fill(self : ImagetransformwarpSlice, v : Double) -> ImagetransformwarpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformwarpSlice::min(self : ImagetransformwarpSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformwarpSlice::max(self : ImagetransformwarpSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformwarpSlice::to_string(self : ImagetransformwarpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

