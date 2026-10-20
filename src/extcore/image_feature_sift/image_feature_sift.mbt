///===
/// extcore/image_feature_sift

pub(all) struct ImagefeaturesiftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_sift_make_point(x : Double, y : Double) -> ImagefeaturesiftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_sift_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturesiftPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturesiftPoint::x(self : ImagefeaturesiftPoint) -> Double { self.x }

pub fn ImagefeaturesiftPoint::y(self : ImagefeaturesiftPoint) -> Double { self.y }

pub fn ImagefeaturesiftPoint::z(self : ImagefeaturesiftPoint) -> Double { self.z }

pub fn ImagefeaturesiftPoint::label(self : ImagefeaturesiftPoint) -> Int { self.label }

pub fn ImagefeaturesiftPoint::dist(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturesiftPoint::add(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturesiftPoint::sub(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturesiftPoint::scale(self : ImagefeaturesiftPoint, s : Double) -> ImagefeaturesiftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturesiftPoint::dot(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturesiftPoint::cross(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturesiftPoint::norm(self : ImagefeaturesiftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturesiftPoint::normalize(self : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesiftPoint::negate(self : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturesiftPoint::mid(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturesiftPoint::lerp(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint, t : Double) -> ImagefeaturesiftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturesiftPoint::to_string(self : ImagefeaturesiftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturesiftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_sift_make_series(vals : Array[Double], name : String) -> ImagefeaturesiftSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturesiftSeries::len(self : ImagefeaturesiftSeries) -> Int { self.vals.length() }

pub fn ImagefeaturesiftSeries::sum(self : ImagefeaturesiftSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturesiftSeries::mean(self : ImagefeaturesiftSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturesiftSeries::min(self : ImagefeaturesiftSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturesiftSeries::max(self : ImagefeaturesiftSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturesiftSeries::range(self : ImagefeaturesiftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturesiftSeries::variance(self : ImagefeaturesiftSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturesiftSeries::std(self : ImagefeaturesiftSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturesiftSeries::median(self : ImagefeaturesiftSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturesiftSeries::scale(self : ImagefeaturesiftSeries, f : Double) -> ImagefeaturesiftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturesiftSeries::add(self : ImagefeaturesiftSeries, other : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturesiftSeries::sub(self : ImagefeaturesiftSeries, other : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturesiftSeries::normalize(self : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturesiftSeries::cumsum(self : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturesiftSeries::to_string(self : ImagefeaturesiftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesiftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_sift_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturesiftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_sift_matrix_identity(n : Int) -> ImagefeaturesiftMatrix {
  let m = image_feature_sift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturesiftMatrix::get(self : ImagefeaturesiftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturesiftMatrix::transpose(self : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  let result = image_feature_sift_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturesiftMatrix::add(self : ImagefeaturesiftMatrix, other : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_sift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturesiftMatrix::scale(self : ImagefeaturesiftMatrix, s : Double) -> ImagefeaturesiftMatrix {
  let result = image_feature_sift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturesiftMatrix::multiply(self : ImagefeaturesiftMatrix, other : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  if self.cols != other.rows { return image_feature_sift_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_sift_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefeaturesiftMatrix::trace(self : ImagefeaturesiftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturesiftMatrix::det(self : ImagefeaturesiftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturesiftMatrix::norm(self : ImagefeaturesiftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturesiftMatrix::to_string(self : ImagefeaturesiftMatrix) -> String {
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

pub(all) struct ImagefeaturesiftVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_sift_make_vector(comps : Array[Double]) -> ImagefeaturesiftVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_sift_vector_zero(dim : Int) -> ImagefeaturesiftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturesiftVector::add(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesiftVector::sub(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesiftVector::scale(self : ImagefeaturesiftVector, s : Double) -> ImagefeaturesiftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturesiftVector::dot(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturesiftVector::norm(self : ImagefeaturesiftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturesiftVector::normalize(self : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesiftVector::dist(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturesiftVector::to_string(self : ImagefeaturesiftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesiftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_frame_make(size : Int) -> ImagefeaturesiftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftFrame::len(self : ImagefeaturesiftFrame) -> Int { self.size }

pub fn ImagefeaturesiftFrame::get(self : ImagefeaturesiftFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftFrame::set(self : ImagefeaturesiftFrame, i : Int, v : Double) -> ImagefeaturesiftFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftFrame::sum(self : ImagefeaturesiftFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftFrame::mean(self : ImagefeaturesiftFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftFrame::scale(self : ImagefeaturesiftFrame, f : Double) -> ImagefeaturesiftFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftFrame::add(self : ImagefeaturesiftFrame, other : ImagefeaturesiftFrame) -> ImagefeaturesiftFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftFrame::copy(self : ImagefeaturesiftFrame) -> ImagefeaturesiftFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftFrame::fill(self : ImagefeaturesiftFrame, v : Double) -> ImagefeaturesiftFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftFrame::min(self : ImagefeaturesiftFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftFrame::max(self : ImagefeaturesiftFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftFrame::to_string(self : ImagefeaturesiftFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_table_make(size : Int) -> ImagefeaturesiftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftTable::len(self : ImagefeaturesiftTable) -> Int { self.size }

pub fn ImagefeaturesiftTable::get(self : ImagefeaturesiftTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftTable::set(self : ImagefeaturesiftTable, i : Int, v : Double) -> ImagefeaturesiftTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftTable::sum(self : ImagefeaturesiftTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftTable::mean(self : ImagefeaturesiftTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftTable::scale(self : ImagefeaturesiftTable, f : Double) -> ImagefeaturesiftTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftTable::add(self : ImagefeaturesiftTable, other : ImagefeaturesiftTable) -> ImagefeaturesiftTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftTable::copy(self : ImagefeaturesiftTable) -> ImagefeaturesiftTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftTable::fill(self : ImagefeaturesiftTable, v : Double) -> ImagefeaturesiftTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftTable::min(self : ImagefeaturesiftTable) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftTable::max(self : ImagefeaturesiftTable) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftTable::to_string(self : ImagefeaturesiftTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_graphn_make(size : Int) -> ImagefeaturesiftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftGraphN::len(self : ImagefeaturesiftGraphN) -> Int { self.size }

pub fn ImagefeaturesiftGraphN::get(self : ImagefeaturesiftGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftGraphN::set(self : ImagefeaturesiftGraphN, i : Int, v : Double) -> ImagefeaturesiftGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftGraphN::sum(self : ImagefeaturesiftGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftGraphN::mean(self : ImagefeaturesiftGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftGraphN::scale(self : ImagefeaturesiftGraphN, f : Double) -> ImagefeaturesiftGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftGraphN::add(self : ImagefeaturesiftGraphN, other : ImagefeaturesiftGraphN) -> ImagefeaturesiftGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftGraphN::copy(self : ImagefeaturesiftGraphN) -> ImagefeaturesiftGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftGraphN::fill(self : ImagefeaturesiftGraphN, v : Double) -> ImagefeaturesiftGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftGraphN::min(self : ImagefeaturesiftGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftGraphN::max(self : ImagefeaturesiftGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftGraphN::to_string(self : ImagefeaturesiftGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_node_make(size : Int) -> ImagefeaturesiftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftNode::len(self : ImagefeaturesiftNode) -> Int { self.size }

pub fn ImagefeaturesiftNode::get(self : ImagefeaturesiftNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftNode::set(self : ImagefeaturesiftNode, i : Int, v : Double) -> ImagefeaturesiftNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftNode::sum(self : ImagefeaturesiftNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftNode::mean(self : ImagefeaturesiftNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftNode::scale(self : ImagefeaturesiftNode, f : Double) -> ImagefeaturesiftNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftNode::add(self : ImagefeaturesiftNode, other : ImagefeaturesiftNode) -> ImagefeaturesiftNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftNode::copy(self : ImagefeaturesiftNode) -> ImagefeaturesiftNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftNode::fill(self : ImagefeaturesiftNode, v : Double) -> ImagefeaturesiftNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftNode::min(self : ImagefeaturesiftNode) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftNode::max(self : ImagefeaturesiftNode) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftNode::to_string(self : ImagefeaturesiftNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_edge_make(size : Int) -> ImagefeaturesiftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftEdge::len(self : ImagefeaturesiftEdge) -> Int { self.size }

pub fn ImagefeaturesiftEdge::get(self : ImagefeaturesiftEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftEdge::set(self : ImagefeaturesiftEdge, i : Int, v : Double) -> ImagefeaturesiftEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftEdge::sum(self : ImagefeaturesiftEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftEdge::mean(self : ImagefeaturesiftEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftEdge::scale(self : ImagefeaturesiftEdge, f : Double) -> ImagefeaturesiftEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftEdge::add(self : ImagefeaturesiftEdge, other : ImagefeaturesiftEdge) -> ImagefeaturesiftEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftEdge::copy(self : ImagefeaturesiftEdge) -> ImagefeaturesiftEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftEdge::fill(self : ImagefeaturesiftEdge, v : Double) -> ImagefeaturesiftEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftEdge::min(self : ImagefeaturesiftEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftEdge::max(self : ImagefeaturesiftEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftEdge::to_string(self : ImagefeaturesiftEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_path_make(size : Int) -> ImagefeaturesiftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftPath::len(self : ImagefeaturesiftPath) -> Int { self.size }

pub fn ImagefeaturesiftPath::get(self : ImagefeaturesiftPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftPath::set(self : ImagefeaturesiftPath, i : Int, v : Double) -> ImagefeaturesiftPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftPath::sum(self : ImagefeaturesiftPath) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftPath::mean(self : ImagefeaturesiftPath) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftPath::scale(self : ImagefeaturesiftPath, f : Double) -> ImagefeaturesiftPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftPath::add(self : ImagefeaturesiftPath, other : ImagefeaturesiftPath) -> ImagefeaturesiftPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftPath::copy(self : ImagefeaturesiftPath) -> ImagefeaturesiftPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftPath::fill(self : ImagefeaturesiftPath, v : Double) -> ImagefeaturesiftPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftPath::min(self : ImagefeaturesiftPath) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftPath::max(self : ImagefeaturesiftPath) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftPath::to_string(self : ImagefeaturesiftPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_cluster_make(size : Int) -> ImagefeaturesiftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftCluster::len(self : ImagefeaturesiftCluster) -> Int { self.size }

pub fn ImagefeaturesiftCluster::get(self : ImagefeaturesiftCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftCluster::set(self : ImagefeaturesiftCluster, i : Int, v : Double) -> ImagefeaturesiftCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCluster::sum(self : ImagefeaturesiftCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftCluster::mean(self : ImagefeaturesiftCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftCluster::scale(self : ImagefeaturesiftCluster, f : Double) -> ImagefeaturesiftCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCluster::add(self : ImagefeaturesiftCluster, other : ImagefeaturesiftCluster) -> ImagefeaturesiftCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftCluster::copy(self : ImagefeaturesiftCluster) -> ImagefeaturesiftCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCluster::fill(self : ImagefeaturesiftCluster, v : Double) -> ImagefeaturesiftCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCluster::min(self : ImagefeaturesiftCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftCluster::max(self : ImagefeaturesiftCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftCluster::to_string(self : ImagefeaturesiftCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_model_make(size : Int) -> ImagefeaturesiftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftModel::len(self : ImagefeaturesiftModel) -> Int { self.size }

pub fn ImagefeaturesiftModel::get(self : ImagefeaturesiftModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftModel::set(self : ImagefeaturesiftModel, i : Int, v : Double) -> ImagefeaturesiftModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftModel::sum(self : ImagefeaturesiftModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftModel::mean(self : ImagefeaturesiftModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftModel::scale(self : ImagefeaturesiftModel, f : Double) -> ImagefeaturesiftModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftModel::add(self : ImagefeaturesiftModel, other : ImagefeaturesiftModel) -> ImagefeaturesiftModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftModel::copy(self : ImagefeaturesiftModel) -> ImagefeaturesiftModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftModel::fill(self : ImagefeaturesiftModel, v : Double) -> ImagefeaturesiftModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftModel::min(self : ImagefeaturesiftModel) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftModel::max(self : ImagefeaturesiftModel) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftModel::to_string(self : ImagefeaturesiftModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_layer_make(size : Int) -> ImagefeaturesiftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftLayer::len(self : ImagefeaturesiftLayer) -> Int { self.size }

pub fn ImagefeaturesiftLayer::get(self : ImagefeaturesiftLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftLayer::set(self : ImagefeaturesiftLayer, i : Int, v : Double) -> ImagefeaturesiftLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftLayer::sum(self : ImagefeaturesiftLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftLayer::mean(self : ImagefeaturesiftLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftLayer::scale(self : ImagefeaturesiftLayer, f : Double) -> ImagefeaturesiftLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftLayer::add(self : ImagefeaturesiftLayer, other : ImagefeaturesiftLayer) -> ImagefeaturesiftLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftLayer::copy(self : ImagefeaturesiftLayer) -> ImagefeaturesiftLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftLayer::fill(self : ImagefeaturesiftLayer, v : Double) -> ImagefeaturesiftLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftLayer::min(self : ImagefeaturesiftLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftLayer::max(self : ImagefeaturesiftLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftLayer::to_string(self : ImagefeaturesiftLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_buffer_make(size : Int) -> ImagefeaturesiftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftBuffer::len(self : ImagefeaturesiftBuffer) -> Int { self.size }

pub fn ImagefeaturesiftBuffer::get(self : ImagefeaturesiftBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftBuffer::set(self : ImagefeaturesiftBuffer, i : Int, v : Double) -> ImagefeaturesiftBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftBuffer::sum(self : ImagefeaturesiftBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftBuffer::mean(self : ImagefeaturesiftBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftBuffer::scale(self : ImagefeaturesiftBuffer, f : Double) -> ImagefeaturesiftBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftBuffer::add(self : ImagefeaturesiftBuffer, other : ImagefeaturesiftBuffer) -> ImagefeaturesiftBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftBuffer::copy(self : ImagefeaturesiftBuffer) -> ImagefeaturesiftBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftBuffer::fill(self : ImagefeaturesiftBuffer, v : Double) -> ImagefeaturesiftBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftBuffer::min(self : ImagefeaturesiftBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftBuffer::max(self : ImagefeaturesiftBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftBuffer::to_string(self : ImagefeaturesiftBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_cursor_make(size : Int) -> ImagefeaturesiftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftCursor::len(self : ImagefeaturesiftCursor) -> Int { self.size }

pub fn ImagefeaturesiftCursor::get(self : ImagefeaturesiftCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftCursor::set(self : ImagefeaturesiftCursor, i : Int, v : Double) -> ImagefeaturesiftCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCursor::sum(self : ImagefeaturesiftCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftCursor::mean(self : ImagefeaturesiftCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftCursor::scale(self : ImagefeaturesiftCursor, f : Double) -> ImagefeaturesiftCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCursor::add(self : ImagefeaturesiftCursor, other : ImagefeaturesiftCursor) -> ImagefeaturesiftCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftCursor::copy(self : ImagefeaturesiftCursor) -> ImagefeaturesiftCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCursor::fill(self : ImagefeaturesiftCursor, v : Double) -> ImagefeaturesiftCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftCursor::min(self : ImagefeaturesiftCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftCursor::max(self : ImagefeaturesiftCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftCursor::to_string(self : ImagefeaturesiftCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_view_make(size : Int) -> ImagefeaturesiftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftView::len(self : ImagefeaturesiftView) -> Int { self.size }

pub fn ImagefeaturesiftView::get(self : ImagefeaturesiftView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftView::set(self : ImagefeaturesiftView, i : Int, v : Double) -> ImagefeaturesiftView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftView::sum(self : ImagefeaturesiftView) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftView::mean(self : ImagefeaturesiftView) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftView::scale(self : ImagefeaturesiftView, f : Double) -> ImagefeaturesiftView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftView::add(self : ImagefeaturesiftView, other : ImagefeaturesiftView) -> ImagefeaturesiftView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftView::copy(self : ImagefeaturesiftView) -> ImagefeaturesiftView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftView::fill(self : ImagefeaturesiftView, v : Double) -> ImagefeaturesiftView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftView::min(self : ImagefeaturesiftView) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftView::max(self : ImagefeaturesiftView) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftView::to_string(self : ImagefeaturesiftView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_range_make(size : Int) -> ImagefeaturesiftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftRange::len(self : ImagefeaturesiftRange) -> Int { self.size }

pub fn ImagefeaturesiftRange::get(self : ImagefeaturesiftRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftRange::set(self : ImagefeaturesiftRange, i : Int, v : Double) -> ImagefeaturesiftRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftRange::sum(self : ImagefeaturesiftRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftRange::mean(self : ImagefeaturesiftRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftRange::scale(self : ImagefeaturesiftRange, f : Double) -> ImagefeaturesiftRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftRange::add(self : ImagefeaturesiftRange, other : ImagefeaturesiftRange) -> ImagefeaturesiftRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftRange::copy(self : ImagefeaturesiftRange) -> ImagefeaturesiftRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftRange::fill(self : ImagefeaturesiftRange, v : Double) -> ImagefeaturesiftRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftRange::min(self : ImagefeaturesiftRange) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftRange::max(self : ImagefeaturesiftRange) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftRange::to_string(self : ImagefeaturesiftRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_slice_make(size : Int) -> ImagefeaturesiftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesiftSlice::len(self : ImagefeaturesiftSlice) -> Int { self.size }

pub fn ImagefeaturesiftSlice::get(self : ImagefeaturesiftSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesiftSlice::set(self : ImagefeaturesiftSlice, i : Int, v : Double) -> ImagefeaturesiftSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftSlice::sum(self : ImagefeaturesiftSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesiftSlice::mean(self : ImagefeaturesiftSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesiftSlice::scale(self : ImagefeaturesiftSlice, f : Double) -> ImagefeaturesiftSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftSlice::add(self : ImagefeaturesiftSlice, other : ImagefeaturesiftSlice) -> ImagefeaturesiftSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesiftSlice::copy(self : ImagefeaturesiftSlice) -> ImagefeaturesiftSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftSlice::fill(self : ImagefeaturesiftSlice, v : Double) -> ImagefeaturesiftSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesiftSlice::min(self : ImagefeaturesiftSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesiftSlice::max(self : ImagefeaturesiftSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesiftSlice::to_string(self : ImagefeaturesiftSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

