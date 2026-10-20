///===
/// extcore/image_feature_fast

pub(all) struct ImagefeaturefastPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_fast_make_point(x : Double, y : Double) -> ImagefeaturefastPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_fast_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturefastPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturefastPoint::x(self : ImagefeaturefastPoint) -> Double { self.x }

pub fn ImagefeaturefastPoint::y(self : ImagefeaturefastPoint) -> Double { self.y }

pub fn ImagefeaturefastPoint::z(self : ImagefeaturefastPoint) -> Double { self.z }

pub fn ImagefeaturefastPoint::label(self : ImagefeaturefastPoint) -> Int { self.label }

pub fn ImagefeaturefastPoint::dist(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturefastPoint::add(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturefastPoint::sub(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturefastPoint::scale(self : ImagefeaturefastPoint, s : Double) -> ImagefeaturefastPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturefastPoint::dot(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturefastPoint::cross(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturefastPoint::norm(self : ImagefeaturefastPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturefastPoint::normalize(self : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturefastPoint::negate(self : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturefastPoint::mid(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturefastPoint::lerp(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint, t : Double) -> ImagefeaturefastPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturefastPoint::to_string(self : ImagefeaturefastPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturefastSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_fast_make_series(vals : Array[Double], name : String) -> ImagefeaturefastSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturefastSeries::len(self : ImagefeaturefastSeries) -> Int { self.vals.length() }

pub fn ImagefeaturefastSeries::sum(self : ImagefeaturefastSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturefastSeries::mean(self : ImagefeaturefastSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturefastSeries::min(self : ImagefeaturefastSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturefastSeries::max(self : ImagefeaturefastSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturefastSeries::range(self : ImagefeaturefastSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturefastSeries::variance(self : ImagefeaturefastSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturefastSeries::std(self : ImagefeaturefastSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturefastSeries::median(self : ImagefeaturefastSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturefastSeries::scale(self : ImagefeaturefastSeries, f : Double) -> ImagefeaturefastSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturefastSeries::add(self : ImagefeaturefastSeries, other : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturefastSeries::sub(self : ImagefeaturefastSeries, other : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturefastSeries::normalize(self : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturefastSeries::cumsum(self : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturefastSeries::to_string(self : ImagefeaturefastSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturefastMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_fast_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturefastMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_feature_fast_matrix_identity(n : Int) -> ImagefeaturefastMatrix {
  let m = image_feature_fast_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturefastMatrix::get(self : ImagefeaturefastMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturefastMatrix::transpose(self : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  let result = image_feature_fast_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturefastMatrix::add(self : ImagefeaturefastMatrix, other : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_fast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturefastMatrix::scale(self : ImagefeaturefastMatrix, s : Double) -> ImagefeaturefastMatrix {
  let result = image_feature_fast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturefastMatrix::multiply(self : ImagefeaturefastMatrix, other : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  if self.cols != other.rows { return image_feature_fast_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_fast_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefeaturefastMatrix::trace(self : ImagefeaturefastMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturefastMatrix::det(self : ImagefeaturefastMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturefastMatrix::norm(self : ImagefeaturefastMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturefastMatrix::to_string(self : ImagefeaturefastMatrix) -> String {
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

pub(all) struct ImagefeaturefastVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_fast_make_vector(comps : Array[Double]) -> ImagefeaturefastVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_fast_vector_zero(dim : Int) -> ImagefeaturefastVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturefastVector::add(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturefastVector::sub(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturefastVector::scale(self : ImagefeaturefastVector, s : Double) -> ImagefeaturefastVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturefastVector::dot(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturefastVector::norm(self : ImagefeaturefastVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturefastVector::normalize(self : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturefastVector::dist(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturefastVector::to_string(self : ImagefeaturefastVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturefastFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_frame_make(size : Int) -> ImagefeaturefastFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastFrame::len(self : ImagefeaturefastFrame) -> Int { self.size }

pub fn ImagefeaturefastFrame::get(self : ImagefeaturefastFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastFrame::set(self : ImagefeaturefastFrame, i : Int, v : Double) -> ImagefeaturefastFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastFrame::sum(self : ImagefeaturefastFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastFrame::mean(self : ImagefeaturefastFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastFrame::scale(self : ImagefeaturefastFrame, f : Double) -> ImagefeaturefastFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastFrame::add(self : ImagefeaturefastFrame, other : ImagefeaturefastFrame) -> ImagefeaturefastFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastFrame::copy(self : ImagefeaturefastFrame) -> ImagefeaturefastFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastFrame::fill(self : ImagefeaturefastFrame, v : Double) -> ImagefeaturefastFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastFrame::min(self : ImagefeaturefastFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastFrame::max(self : ImagefeaturefastFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastFrame::to_string(self : ImagefeaturefastFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_table_make(size : Int) -> ImagefeaturefastTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastTable::len(self : ImagefeaturefastTable) -> Int { self.size }

pub fn ImagefeaturefastTable::get(self : ImagefeaturefastTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastTable::set(self : ImagefeaturefastTable, i : Int, v : Double) -> ImagefeaturefastTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastTable::sum(self : ImagefeaturefastTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastTable::mean(self : ImagefeaturefastTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastTable::scale(self : ImagefeaturefastTable, f : Double) -> ImagefeaturefastTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastTable::add(self : ImagefeaturefastTable, other : ImagefeaturefastTable) -> ImagefeaturefastTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastTable::copy(self : ImagefeaturefastTable) -> ImagefeaturefastTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastTable::fill(self : ImagefeaturefastTable, v : Double) -> ImagefeaturefastTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastTable::min(self : ImagefeaturefastTable) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastTable::max(self : ImagefeaturefastTable) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastTable::to_string(self : ImagefeaturefastTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_graphn_make(size : Int) -> ImagefeaturefastGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastGraphN::len(self : ImagefeaturefastGraphN) -> Int { self.size }

pub fn ImagefeaturefastGraphN::get(self : ImagefeaturefastGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastGraphN::set(self : ImagefeaturefastGraphN, i : Int, v : Double) -> ImagefeaturefastGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastGraphN::sum(self : ImagefeaturefastGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastGraphN::mean(self : ImagefeaturefastGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastGraphN::scale(self : ImagefeaturefastGraphN, f : Double) -> ImagefeaturefastGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastGraphN::add(self : ImagefeaturefastGraphN, other : ImagefeaturefastGraphN) -> ImagefeaturefastGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastGraphN::copy(self : ImagefeaturefastGraphN) -> ImagefeaturefastGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastGraphN::fill(self : ImagefeaturefastGraphN, v : Double) -> ImagefeaturefastGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastGraphN::min(self : ImagefeaturefastGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastGraphN::max(self : ImagefeaturefastGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastGraphN::to_string(self : ImagefeaturefastGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_node_make(size : Int) -> ImagefeaturefastNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastNode::len(self : ImagefeaturefastNode) -> Int { self.size }

pub fn ImagefeaturefastNode::get(self : ImagefeaturefastNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastNode::set(self : ImagefeaturefastNode, i : Int, v : Double) -> ImagefeaturefastNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastNode::sum(self : ImagefeaturefastNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastNode::mean(self : ImagefeaturefastNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastNode::scale(self : ImagefeaturefastNode, f : Double) -> ImagefeaturefastNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastNode::add(self : ImagefeaturefastNode, other : ImagefeaturefastNode) -> ImagefeaturefastNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastNode::copy(self : ImagefeaturefastNode) -> ImagefeaturefastNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastNode::fill(self : ImagefeaturefastNode, v : Double) -> ImagefeaturefastNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastNode::min(self : ImagefeaturefastNode) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastNode::max(self : ImagefeaturefastNode) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastNode::to_string(self : ImagefeaturefastNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_edge_make(size : Int) -> ImagefeaturefastEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastEdge::len(self : ImagefeaturefastEdge) -> Int { self.size }

pub fn ImagefeaturefastEdge::get(self : ImagefeaturefastEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastEdge::set(self : ImagefeaturefastEdge, i : Int, v : Double) -> ImagefeaturefastEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastEdge::sum(self : ImagefeaturefastEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastEdge::mean(self : ImagefeaturefastEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastEdge::scale(self : ImagefeaturefastEdge, f : Double) -> ImagefeaturefastEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastEdge::add(self : ImagefeaturefastEdge, other : ImagefeaturefastEdge) -> ImagefeaturefastEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastEdge::copy(self : ImagefeaturefastEdge) -> ImagefeaturefastEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastEdge::fill(self : ImagefeaturefastEdge, v : Double) -> ImagefeaturefastEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastEdge::min(self : ImagefeaturefastEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastEdge::max(self : ImagefeaturefastEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastEdge::to_string(self : ImagefeaturefastEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_path_make(size : Int) -> ImagefeaturefastPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastPath::len(self : ImagefeaturefastPath) -> Int { self.size }

pub fn ImagefeaturefastPath::get(self : ImagefeaturefastPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastPath::set(self : ImagefeaturefastPath, i : Int, v : Double) -> ImagefeaturefastPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastPath::sum(self : ImagefeaturefastPath) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastPath::mean(self : ImagefeaturefastPath) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastPath::scale(self : ImagefeaturefastPath, f : Double) -> ImagefeaturefastPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastPath::add(self : ImagefeaturefastPath, other : ImagefeaturefastPath) -> ImagefeaturefastPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastPath::copy(self : ImagefeaturefastPath) -> ImagefeaturefastPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastPath::fill(self : ImagefeaturefastPath, v : Double) -> ImagefeaturefastPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastPath::min(self : ImagefeaturefastPath) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastPath::max(self : ImagefeaturefastPath) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastPath::to_string(self : ImagefeaturefastPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_cluster_make(size : Int) -> ImagefeaturefastCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastCluster::len(self : ImagefeaturefastCluster) -> Int { self.size }

pub fn ImagefeaturefastCluster::get(self : ImagefeaturefastCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastCluster::set(self : ImagefeaturefastCluster, i : Int, v : Double) -> ImagefeaturefastCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCluster::sum(self : ImagefeaturefastCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastCluster::mean(self : ImagefeaturefastCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastCluster::scale(self : ImagefeaturefastCluster, f : Double) -> ImagefeaturefastCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCluster::add(self : ImagefeaturefastCluster, other : ImagefeaturefastCluster) -> ImagefeaturefastCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastCluster::copy(self : ImagefeaturefastCluster) -> ImagefeaturefastCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCluster::fill(self : ImagefeaturefastCluster, v : Double) -> ImagefeaturefastCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCluster::min(self : ImagefeaturefastCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastCluster::max(self : ImagefeaturefastCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastCluster::to_string(self : ImagefeaturefastCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_model_make(size : Int) -> ImagefeaturefastModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastModel::len(self : ImagefeaturefastModel) -> Int { self.size }

pub fn ImagefeaturefastModel::get(self : ImagefeaturefastModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastModel::set(self : ImagefeaturefastModel, i : Int, v : Double) -> ImagefeaturefastModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastModel::sum(self : ImagefeaturefastModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastModel::mean(self : ImagefeaturefastModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastModel::scale(self : ImagefeaturefastModel, f : Double) -> ImagefeaturefastModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastModel::add(self : ImagefeaturefastModel, other : ImagefeaturefastModel) -> ImagefeaturefastModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastModel::copy(self : ImagefeaturefastModel) -> ImagefeaturefastModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastModel::fill(self : ImagefeaturefastModel, v : Double) -> ImagefeaturefastModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastModel::min(self : ImagefeaturefastModel) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastModel::max(self : ImagefeaturefastModel) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastModel::to_string(self : ImagefeaturefastModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_layer_make(size : Int) -> ImagefeaturefastLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastLayer::len(self : ImagefeaturefastLayer) -> Int { self.size }

pub fn ImagefeaturefastLayer::get(self : ImagefeaturefastLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastLayer::set(self : ImagefeaturefastLayer, i : Int, v : Double) -> ImagefeaturefastLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastLayer::sum(self : ImagefeaturefastLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastLayer::mean(self : ImagefeaturefastLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastLayer::scale(self : ImagefeaturefastLayer, f : Double) -> ImagefeaturefastLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastLayer::add(self : ImagefeaturefastLayer, other : ImagefeaturefastLayer) -> ImagefeaturefastLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastLayer::copy(self : ImagefeaturefastLayer) -> ImagefeaturefastLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastLayer::fill(self : ImagefeaturefastLayer, v : Double) -> ImagefeaturefastLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastLayer::min(self : ImagefeaturefastLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastLayer::max(self : ImagefeaturefastLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastLayer::to_string(self : ImagefeaturefastLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_buffer_make(size : Int) -> ImagefeaturefastBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastBuffer::len(self : ImagefeaturefastBuffer) -> Int { self.size }

pub fn ImagefeaturefastBuffer::get(self : ImagefeaturefastBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastBuffer::set(self : ImagefeaturefastBuffer, i : Int, v : Double) -> ImagefeaturefastBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastBuffer::sum(self : ImagefeaturefastBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastBuffer::mean(self : ImagefeaturefastBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastBuffer::scale(self : ImagefeaturefastBuffer, f : Double) -> ImagefeaturefastBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastBuffer::add(self : ImagefeaturefastBuffer, other : ImagefeaturefastBuffer) -> ImagefeaturefastBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastBuffer::copy(self : ImagefeaturefastBuffer) -> ImagefeaturefastBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastBuffer::fill(self : ImagefeaturefastBuffer, v : Double) -> ImagefeaturefastBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastBuffer::min(self : ImagefeaturefastBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastBuffer::max(self : ImagefeaturefastBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastBuffer::to_string(self : ImagefeaturefastBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_cursor_make(size : Int) -> ImagefeaturefastCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastCursor::len(self : ImagefeaturefastCursor) -> Int { self.size }

pub fn ImagefeaturefastCursor::get(self : ImagefeaturefastCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastCursor::set(self : ImagefeaturefastCursor, i : Int, v : Double) -> ImagefeaturefastCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCursor::sum(self : ImagefeaturefastCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastCursor::mean(self : ImagefeaturefastCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastCursor::scale(self : ImagefeaturefastCursor, f : Double) -> ImagefeaturefastCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCursor::add(self : ImagefeaturefastCursor, other : ImagefeaturefastCursor) -> ImagefeaturefastCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastCursor::copy(self : ImagefeaturefastCursor) -> ImagefeaturefastCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCursor::fill(self : ImagefeaturefastCursor, v : Double) -> ImagefeaturefastCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastCursor::min(self : ImagefeaturefastCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastCursor::max(self : ImagefeaturefastCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastCursor::to_string(self : ImagefeaturefastCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_view_make(size : Int) -> ImagefeaturefastView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastView::len(self : ImagefeaturefastView) -> Int { self.size }

pub fn ImagefeaturefastView::get(self : ImagefeaturefastView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastView::set(self : ImagefeaturefastView, i : Int, v : Double) -> ImagefeaturefastView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastView::sum(self : ImagefeaturefastView) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastView::mean(self : ImagefeaturefastView) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastView::scale(self : ImagefeaturefastView, f : Double) -> ImagefeaturefastView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastView::add(self : ImagefeaturefastView, other : ImagefeaturefastView) -> ImagefeaturefastView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastView::copy(self : ImagefeaturefastView) -> ImagefeaturefastView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastView::fill(self : ImagefeaturefastView, v : Double) -> ImagefeaturefastView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastView::min(self : ImagefeaturefastView) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastView::max(self : ImagefeaturefastView) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastView::to_string(self : ImagefeaturefastView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_range_make(size : Int) -> ImagefeaturefastRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastRange::len(self : ImagefeaturefastRange) -> Int { self.size }

pub fn ImagefeaturefastRange::get(self : ImagefeaturefastRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastRange::set(self : ImagefeaturefastRange, i : Int, v : Double) -> ImagefeaturefastRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastRange::sum(self : ImagefeaturefastRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastRange::mean(self : ImagefeaturefastRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastRange::scale(self : ImagefeaturefastRange, f : Double) -> ImagefeaturefastRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastRange::add(self : ImagefeaturefastRange, other : ImagefeaturefastRange) -> ImagefeaturefastRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastRange::copy(self : ImagefeaturefastRange) -> ImagefeaturefastRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastRange::fill(self : ImagefeaturefastRange, v : Double) -> ImagefeaturefastRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastRange::min(self : ImagefeaturefastRange) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastRange::max(self : ImagefeaturefastRange) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastRange::to_string(self : ImagefeaturefastRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_slice_make(size : Int) -> ImagefeaturefastSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturefastSlice::len(self : ImagefeaturefastSlice) -> Int { self.size }

pub fn ImagefeaturefastSlice::get(self : ImagefeaturefastSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturefastSlice::set(self : ImagefeaturefastSlice, i : Int, v : Double) -> ImagefeaturefastSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastSlice::sum(self : ImagefeaturefastSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturefastSlice::mean(self : ImagefeaturefastSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturefastSlice::scale(self : ImagefeaturefastSlice, f : Double) -> ImagefeaturefastSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastSlice::add(self : ImagefeaturefastSlice, other : ImagefeaturefastSlice) -> ImagefeaturefastSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturefastSlice::copy(self : ImagefeaturefastSlice) -> ImagefeaturefastSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastSlice::fill(self : ImagefeaturefastSlice, v : Double) -> ImagefeaturefastSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturefastSlice::min(self : ImagefeaturefastSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeaturefastSlice::max(self : ImagefeaturefastSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeaturefastSlice::to_string(self : ImagefeaturefastSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

