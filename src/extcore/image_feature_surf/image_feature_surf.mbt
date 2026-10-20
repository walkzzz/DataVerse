///===
/// extcore/image_feature_surf

pub(all) struct ImagefeaturesurfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_surf_make_point(x : Double, y : Double) -> ImagefeaturesurfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_surf_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturesurfPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturesurfPoint::x(self : ImagefeaturesurfPoint) -> Double { self.x }

pub fn ImagefeaturesurfPoint::y(self : ImagefeaturesurfPoint) -> Double { self.y }

pub fn ImagefeaturesurfPoint::z(self : ImagefeaturesurfPoint) -> Double { self.z }

pub fn ImagefeaturesurfPoint::label(self : ImagefeaturesurfPoint) -> Int { self.label }

pub fn ImagefeaturesurfPoint::dist(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturesurfPoint::add(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturesurfPoint::sub(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturesurfPoint::scale(self : ImagefeaturesurfPoint, s : Double) -> ImagefeaturesurfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturesurfPoint::dot(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturesurfPoint::cross(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturesurfPoint::norm(self : ImagefeaturesurfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturesurfPoint::normalize(self : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesurfPoint::negate(self : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturesurfPoint::mid(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturesurfPoint::lerp(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint, t : Double) -> ImagefeaturesurfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturesurfPoint::to_string(self : ImagefeaturesurfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturesurfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_surf_make_series(vals : Array[Double], name : String) -> ImagefeaturesurfSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturesurfSeries::len(self : ImagefeaturesurfSeries) -> Int { self.vals.length() }

pub fn ImagefeaturesurfSeries::sum(self : ImagefeaturesurfSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturesurfSeries::mean(self : ImagefeaturesurfSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturesurfSeries::min(self : ImagefeaturesurfSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturesurfSeries::max(self : ImagefeaturesurfSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturesurfSeries::range(self : ImagefeaturesurfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturesurfSeries::variance(self : ImagefeaturesurfSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturesurfSeries::std(self : ImagefeaturesurfSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturesurfSeries::median(self : ImagefeaturesurfSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturesurfSeries::scale(self : ImagefeaturesurfSeries, f : Double) -> ImagefeaturesurfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturesurfSeries::add(self : ImagefeaturesurfSeries, other : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturesurfSeries::sub(self : ImagefeaturesurfSeries, other : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturesurfSeries::normalize(self : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturesurfSeries::cumsum(self : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturesurfSeries::to_string(self : ImagefeaturesurfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesurfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_surf_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturesurfMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_feature_surf_matrix_identity(n : Int) -> ImagefeaturesurfMatrix {
  let m = image_feature_surf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturesurfMatrix::get(self : ImagefeaturesurfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturesurfMatrix::transpose(self : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  let result = image_feature_surf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturesurfMatrix::add(self : ImagefeaturesurfMatrix, other : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_surf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturesurfMatrix::scale(self : ImagefeaturesurfMatrix, s : Double) -> ImagefeaturesurfMatrix {
  let result = image_feature_surf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturesurfMatrix::multiply(self : ImagefeaturesurfMatrix, other : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  if self.cols != other.rows { return image_feature_surf_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_surf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefeaturesurfMatrix::trace(self : ImagefeaturesurfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturesurfMatrix::det(self : ImagefeaturesurfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturesurfMatrix::norm(self : ImagefeaturesurfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturesurfMatrix::to_string(self : ImagefeaturesurfMatrix) -> String {
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

pub(all) struct ImagefeaturesurfVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_surf_make_vector(comps : Array[Double]) -> ImagefeaturesurfVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_surf_vector_zero(dim : Int) -> ImagefeaturesurfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturesurfVector::add(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesurfVector::sub(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesurfVector::scale(self : ImagefeaturesurfVector, s : Double) -> ImagefeaturesurfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturesurfVector::dot(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturesurfVector::norm(self : ImagefeaturesurfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturesurfVector::normalize(self : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesurfVector::dist(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturesurfVector::to_string(self : ImagefeaturesurfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesurfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_frame_make(size : Int) -> ImagefeaturesurfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfFrame::len(self : ImagefeaturesurfFrame) -> Int { self.size }

pub fn ImagefeaturesurfFrame::get(self : ImagefeaturesurfFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfFrame::set(self : ImagefeaturesurfFrame, i : Int, v : Double) -> ImagefeaturesurfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfFrame::sum(self : ImagefeaturesurfFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfFrame::mean(self : ImagefeaturesurfFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfFrame::scale(self : ImagefeaturesurfFrame, f : Double) -> ImagefeaturesurfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfFrame::add(self : ImagefeaturesurfFrame, other : ImagefeaturesurfFrame) -> ImagefeaturesurfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfFrame::copy(self : ImagefeaturesurfFrame) -> ImagefeaturesurfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfFrame::fill(self : ImagefeaturesurfFrame, v : Double) -> ImagefeaturesurfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfFrame::min(self : ImagefeaturesurfFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfFrame::max(self : ImagefeaturesurfFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfFrame::to_string(self : ImagefeaturesurfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_table_make(size : Int) -> ImagefeaturesurfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfTable::len(self : ImagefeaturesurfTable) -> Int { self.size }

pub fn ImagefeaturesurfTable::get(self : ImagefeaturesurfTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfTable::set(self : ImagefeaturesurfTable, i : Int, v : Double) -> ImagefeaturesurfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfTable::sum(self : ImagefeaturesurfTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfTable::mean(self : ImagefeaturesurfTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfTable::scale(self : ImagefeaturesurfTable, f : Double) -> ImagefeaturesurfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfTable::add(self : ImagefeaturesurfTable, other : ImagefeaturesurfTable) -> ImagefeaturesurfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfTable::copy(self : ImagefeaturesurfTable) -> ImagefeaturesurfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfTable::fill(self : ImagefeaturesurfTable, v : Double) -> ImagefeaturesurfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfTable::min(self : ImagefeaturesurfTable) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfTable::max(self : ImagefeaturesurfTable) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfTable::to_string(self : ImagefeaturesurfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_graphn_make(size : Int) -> ImagefeaturesurfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfGraphN::len(self : ImagefeaturesurfGraphN) -> Int { self.size }

pub fn ImagefeaturesurfGraphN::get(self : ImagefeaturesurfGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfGraphN::set(self : ImagefeaturesurfGraphN, i : Int, v : Double) -> ImagefeaturesurfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfGraphN::sum(self : ImagefeaturesurfGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfGraphN::mean(self : ImagefeaturesurfGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfGraphN::scale(self : ImagefeaturesurfGraphN, f : Double) -> ImagefeaturesurfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfGraphN::add(self : ImagefeaturesurfGraphN, other : ImagefeaturesurfGraphN) -> ImagefeaturesurfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfGraphN::copy(self : ImagefeaturesurfGraphN) -> ImagefeaturesurfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfGraphN::fill(self : ImagefeaturesurfGraphN, v : Double) -> ImagefeaturesurfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfGraphN::min(self : ImagefeaturesurfGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfGraphN::max(self : ImagefeaturesurfGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfGraphN::to_string(self : ImagefeaturesurfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_node_make(size : Int) -> ImagefeaturesurfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfNode::len(self : ImagefeaturesurfNode) -> Int { self.size }

pub fn ImagefeaturesurfNode::get(self : ImagefeaturesurfNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfNode::set(self : ImagefeaturesurfNode, i : Int, v : Double) -> ImagefeaturesurfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfNode::sum(self : ImagefeaturesurfNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfNode::mean(self : ImagefeaturesurfNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfNode::scale(self : ImagefeaturesurfNode, f : Double) -> ImagefeaturesurfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfNode::add(self : ImagefeaturesurfNode, other : ImagefeaturesurfNode) -> ImagefeaturesurfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfNode::copy(self : ImagefeaturesurfNode) -> ImagefeaturesurfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfNode::fill(self : ImagefeaturesurfNode, v : Double) -> ImagefeaturesurfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfNode::min(self : ImagefeaturesurfNode) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfNode::max(self : ImagefeaturesurfNode) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfNode::to_string(self : ImagefeaturesurfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_edge_make(size : Int) -> ImagefeaturesurfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfEdge::len(self : ImagefeaturesurfEdge) -> Int { self.size }

pub fn ImagefeaturesurfEdge::get(self : ImagefeaturesurfEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfEdge::set(self : ImagefeaturesurfEdge, i : Int, v : Double) -> ImagefeaturesurfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfEdge::sum(self : ImagefeaturesurfEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfEdge::mean(self : ImagefeaturesurfEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfEdge::scale(self : ImagefeaturesurfEdge, f : Double) -> ImagefeaturesurfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfEdge::add(self : ImagefeaturesurfEdge, other : ImagefeaturesurfEdge) -> ImagefeaturesurfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfEdge::copy(self : ImagefeaturesurfEdge) -> ImagefeaturesurfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfEdge::fill(self : ImagefeaturesurfEdge, v : Double) -> ImagefeaturesurfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfEdge::min(self : ImagefeaturesurfEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfEdge::max(self : ImagefeaturesurfEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfEdge::to_string(self : ImagefeaturesurfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_path_make(size : Int) -> ImagefeaturesurfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfPath::len(self : ImagefeaturesurfPath) -> Int { self.size }

pub fn ImagefeaturesurfPath::get(self : ImagefeaturesurfPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfPath::set(self : ImagefeaturesurfPath, i : Int, v : Double) -> ImagefeaturesurfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfPath::sum(self : ImagefeaturesurfPath) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfPath::mean(self : ImagefeaturesurfPath) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfPath::scale(self : ImagefeaturesurfPath, f : Double) -> ImagefeaturesurfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfPath::add(self : ImagefeaturesurfPath, other : ImagefeaturesurfPath) -> ImagefeaturesurfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfPath::copy(self : ImagefeaturesurfPath) -> ImagefeaturesurfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfPath::fill(self : ImagefeaturesurfPath, v : Double) -> ImagefeaturesurfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfPath::min(self : ImagefeaturesurfPath) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfPath::max(self : ImagefeaturesurfPath) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfPath::to_string(self : ImagefeaturesurfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_cluster_make(size : Int) -> ImagefeaturesurfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfCluster::len(self : ImagefeaturesurfCluster) -> Int { self.size }

pub fn ImagefeaturesurfCluster::get(self : ImagefeaturesurfCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfCluster::set(self : ImagefeaturesurfCluster, i : Int, v : Double) -> ImagefeaturesurfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCluster::sum(self : ImagefeaturesurfCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfCluster::mean(self : ImagefeaturesurfCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfCluster::scale(self : ImagefeaturesurfCluster, f : Double) -> ImagefeaturesurfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCluster::add(self : ImagefeaturesurfCluster, other : ImagefeaturesurfCluster) -> ImagefeaturesurfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfCluster::copy(self : ImagefeaturesurfCluster) -> ImagefeaturesurfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCluster::fill(self : ImagefeaturesurfCluster, v : Double) -> ImagefeaturesurfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCluster::min(self : ImagefeaturesurfCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfCluster::max(self : ImagefeaturesurfCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfCluster::to_string(self : ImagefeaturesurfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_model_make(size : Int) -> ImagefeaturesurfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfModel::len(self : ImagefeaturesurfModel) -> Int { self.size }

pub fn ImagefeaturesurfModel::get(self : ImagefeaturesurfModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfModel::set(self : ImagefeaturesurfModel, i : Int, v : Double) -> ImagefeaturesurfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfModel::sum(self : ImagefeaturesurfModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfModel::mean(self : ImagefeaturesurfModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfModel::scale(self : ImagefeaturesurfModel, f : Double) -> ImagefeaturesurfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfModel::add(self : ImagefeaturesurfModel, other : ImagefeaturesurfModel) -> ImagefeaturesurfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfModel::copy(self : ImagefeaturesurfModel) -> ImagefeaturesurfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfModel::fill(self : ImagefeaturesurfModel, v : Double) -> ImagefeaturesurfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfModel::min(self : ImagefeaturesurfModel) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfModel::max(self : ImagefeaturesurfModel) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfModel::to_string(self : ImagefeaturesurfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_layer_make(size : Int) -> ImagefeaturesurfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfLayer::len(self : ImagefeaturesurfLayer) -> Int { self.size }

pub fn ImagefeaturesurfLayer::get(self : ImagefeaturesurfLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfLayer::set(self : ImagefeaturesurfLayer, i : Int, v : Double) -> ImagefeaturesurfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfLayer::sum(self : ImagefeaturesurfLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfLayer::mean(self : ImagefeaturesurfLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfLayer::scale(self : ImagefeaturesurfLayer, f : Double) -> ImagefeaturesurfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfLayer::add(self : ImagefeaturesurfLayer, other : ImagefeaturesurfLayer) -> ImagefeaturesurfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfLayer::copy(self : ImagefeaturesurfLayer) -> ImagefeaturesurfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfLayer::fill(self : ImagefeaturesurfLayer, v : Double) -> ImagefeaturesurfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfLayer::min(self : ImagefeaturesurfLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfLayer::max(self : ImagefeaturesurfLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfLayer::to_string(self : ImagefeaturesurfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_buffer_make(size : Int) -> ImagefeaturesurfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfBuffer::len(self : ImagefeaturesurfBuffer) -> Int { self.size }

pub fn ImagefeaturesurfBuffer::get(self : ImagefeaturesurfBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfBuffer::set(self : ImagefeaturesurfBuffer, i : Int, v : Double) -> ImagefeaturesurfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfBuffer::sum(self : ImagefeaturesurfBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfBuffer::mean(self : ImagefeaturesurfBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfBuffer::scale(self : ImagefeaturesurfBuffer, f : Double) -> ImagefeaturesurfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfBuffer::add(self : ImagefeaturesurfBuffer, other : ImagefeaturesurfBuffer) -> ImagefeaturesurfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfBuffer::copy(self : ImagefeaturesurfBuffer) -> ImagefeaturesurfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfBuffer::fill(self : ImagefeaturesurfBuffer, v : Double) -> ImagefeaturesurfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfBuffer::min(self : ImagefeaturesurfBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfBuffer::max(self : ImagefeaturesurfBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfBuffer::to_string(self : ImagefeaturesurfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_cursor_make(size : Int) -> ImagefeaturesurfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfCursor::len(self : ImagefeaturesurfCursor) -> Int { self.size }

pub fn ImagefeaturesurfCursor::get(self : ImagefeaturesurfCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfCursor::set(self : ImagefeaturesurfCursor, i : Int, v : Double) -> ImagefeaturesurfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCursor::sum(self : ImagefeaturesurfCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfCursor::mean(self : ImagefeaturesurfCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfCursor::scale(self : ImagefeaturesurfCursor, f : Double) -> ImagefeaturesurfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCursor::add(self : ImagefeaturesurfCursor, other : ImagefeaturesurfCursor) -> ImagefeaturesurfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfCursor::copy(self : ImagefeaturesurfCursor) -> ImagefeaturesurfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCursor::fill(self : ImagefeaturesurfCursor, v : Double) -> ImagefeaturesurfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfCursor::min(self : ImagefeaturesurfCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfCursor::max(self : ImagefeaturesurfCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfCursor::to_string(self : ImagefeaturesurfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_view_make(size : Int) -> ImagefeaturesurfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfView::len(self : ImagefeaturesurfView) -> Int { self.size }

pub fn ImagefeaturesurfView::get(self : ImagefeaturesurfView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfView::set(self : ImagefeaturesurfView, i : Int, v : Double) -> ImagefeaturesurfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfView::sum(self : ImagefeaturesurfView) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfView::mean(self : ImagefeaturesurfView) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfView::scale(self : ImagefeaturesurfView, f : Double) -> ImagefeaturesurfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfView::add(self : ImagefeaturesurfView, other : ImagefeaturesurfView) -> ImagefeaturesurfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfView::copy(self : ImagefeaturesurfView) -> ImagefeaturesurfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfView::fill(self : ImagefeaturesurfView, v : Double) -> ImagefeaturesurfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfView::min(self : ImagefeaturesurfView) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfView::max(self : ImagefeaturesurfView) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfView::to_string(self : ImagefeaturesurfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_range_make(size : Int) -> ImagefeaturesurfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfRange::len(self : ImagefeaturesurfRange) -> Int { self.size }

pub fn ImagefeaturesurfRange::get(self : ImagefeaturesurfRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfRange::set(self : ImagefeaturesurfRange, i : Int, v : Double) -> ImagefeaturesurfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfRange::sum(self : ImagefeaturesurfRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfRange::mean(self : ImagefeaturesurfRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfRange::scale(self : ImagefeaturesurfRange, f : Double) -> ImagefeaturesurfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfRange::add(self : ImagefeaturesurfRange, other : ImagefeaturesurfRange) -> ImagefeaturesurfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfRange::copy(self : ImagefeaturesurfRange) -> ImagefeaturesurfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfRange::fill(self : ImagefeaturesurfRange, v : Double) -> ImagefeaturesurfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfRange::min(self : ImagefeaturesurfRange) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfRange::max(self : ImagefeaturesurfRange) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfRange::to_string(self : ImagefeaturesurfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_slice_make(size : Int) -> ImagefeaturesurfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturesurfSlice::len(self : ImagefeaturesurfSlice) -> Int { self.size }

pub fn ImagefeaturesurfSlice::get(self : ImagefeaturesurfSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturesurfSlice::set(self : ImagefeaturesurfSlice, i : Int, v : Double) -> ImagefeaturesurfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfSlice::sum(self : ImagefeaturesurfSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturesurfSlice::mean(self : ImagefeaturesurfSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturesurfSlice::scale(self : ImagefeaturesurfSlice, f : Double) -> ImagefeaturesurfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfSlice::add(self : ImagefeaturesurfSlice, other : ImagefeaturesurfSlice) -> ImagefeaturesurfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturesurfSlice::copy(self : ImagefeaturesurfSlice) -> ImagefeaturesurfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfSlice::fill(self : ImagefeaturesurfSlice, v : Double) -> ImagefeaturesurfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturesurfSlice::min(self : ImagefeaturesurfSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeaturesurfSlice::max(self : ImagefeaturesurfSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeaturesurfSlice::to_string(self : ImagefeaturesurfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

