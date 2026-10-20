///===
/// extcore/image_feature_akaze

pub(all) struct ImagefeatureakazePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_akaze_make_point(x : Double, y : Double) -> ImagefeatureakazePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_akaze_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureakazePoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeatureakazePoint::x(self : ImagefeatureakazePoint) -> Double { self.x }

pub fn ImagefeatureakazePoint::y(self : ImagefeatureakazePoint) -> Double { self.y }

pub fn ImagefeatureakazePoint::z(self : ImagefeatureakazePoint) -> Double { self.z }

pub fn ImagefeatureakazePoint::label(self : ImagefeatureakazePoint) -> Int { self.label }

pub fn ImagefeatureakazePoint::dist(self : ImagefeatureakazePoint, other : ImagefeatureakazePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeatureakazePoint::add(self : ImagefeatureakazePoint, other : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeatureakazePoint::sub(self : ImagefeatureakazePoint, other : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeatureakazePoint::scale(self : ImagefeatureakazePoint, s : Double) -> ImagefeatureakazePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeatureakazePoint::dot(self : ImagefeatureakazePoint, other : ImagefeatureakazePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeatureakazePoint::cross(self : ImagefeatureakazePoint, other : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeatureakazePoint::norm(self : ImagefeatureakazePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeatureakazePoint::normalize(self : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureakazePoint::negate(self : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeatureakazePoint::mid(self : ImagefeatureakazePoint, other : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeatureakazePoint::lerp(self : ImagefeatureakazePoint, other : ImagefeatureakazePoint, t : Double) -> ImagefeatureakazePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeatureakazePoint::to_string(self : ImagefeatureakazePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeatureakazeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_akaze_make_series(vals : Array[Double], name : String) -> ImagefeatureakazeSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeatureakazeSeries::len(self : ImagefeatureakazeSeries) -> Int { self.vals.length() }

pub fn ImagefeatureakazeSeries::sum(self : ImagefeatureakazeSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeatureakazeSeries::mean(self : ImagefeatureakazeSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeatureakazeSeries::min(self : ImagefeatureakazeSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeatureakazeSeries::max(self : ImagefeatureakazeSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeatureakazeSeries::range(self : ImagefeatureakazeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeatureakazeSeries::variance(self : ImagefeatureakazeSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeatureakazeSeries::std(self : ImagefeatureakazeSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeatureakazeSeries::median(self : ImagefeatureakazeSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeatureakazeSeries::scale(self : ImagefeatureakazeSeries, f : Double) -> ImagefeatureakazeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeatureakazeSeries::add(self : ImagefeatureakazeSeries, other : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeatureakazeSeries::sub(self : ImagefeatureakazeSeries, other : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeatureakazeSeries::normalize(self : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeatureakazeSeries::cumsum(self : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeatureakazeSeries::to_string(self : ImagefeatureakazeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureakazeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_akaze_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureakazeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_akaze_matrix_identity(n : Int) -> ImagefeatureakazeMatrix {
  let m = image_feature_akaze_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeatureakazeMatrix::get(self : ImagefeatureakazeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeatureakazeMatrix::transpose(self : ImagefeatureakazeMatrix) -> ImagefeatureakazeMatrix {
  let result = image_feature_akaze_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeatureakazeMatrix::add(self : ImagefeatureakazeMatrix, other : ImagefeatureakazeMatrix) -> ImagefeatureakazeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_akaze_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeatureakazeMatrix::scale(self : ImagefeatureakazeMatrix, s : Double) -> ImagefeatureakazeMatrix {
  let result = image_feature_akaze_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeatureakazeMatrix::multiply(self : ImagefeatureakazeMatrix, other : ImagefeatureakazeMatrix) -> ImagefeatureakazeMatrix {
  if self.cols != other.rows { return image_feature_akaze_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_akaze_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeatureakazeMatrix::trace(self : ImagefeatureakazeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeatureakazeMatrix::det(self : ImagefeatureakazeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeatureakazeMatrix::norm(self : ImagefeatureakazeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeatureakazeMatrix::to_string(self : ImagefeatureakazeMatrix) -> String {
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

pub(all) struct ImagefeatureakazeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_akaze_make_vector(comps : Array[Double]) -> ImagefeatureakazeVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_akaze_vector_zero(dim : Int) -> ImagefeatureakazeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeatureakazeVector::add(self : ImagefeatureakazeVector, other : ImagefeatureakazeVector) -> ImagefeatureakazeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureakazeVector::sub(self : ImagefeatureakazeVector, other : ImagefeatureakazeVector) -> ImagefeatureakazeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureakazeVector::scale(self : ImagefeatureakazeVector, s : Double) -> ImagefeatureakazeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeatureakazeVector::dot(self : ImagefeatureakazeVector, other : ImagefeatureakazeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeatureakazeVector::norm(self : ImagefeatureakazeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeatureakazeVector::normalize(self : ImagefeatureakazeVector) -> ImagefeatureakazeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureakazeVector::dist(self : ImagefeatureakazeVector, other : ImagefeatureakazeVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeatureakazeVector::to_string(self : ImagefeatureakazeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureakazeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_frame_make(size : Int) -> ImagefeatureakazeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeFrame::len(self : ImagefeatureakazeFrame) -> Int { self.size }

pub fn ImagefeatureakazeFrame::get(self : ImagefeatureakazeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeFrame::set(self : ImagefeatureakazeFrame, i : Int, v : Double) -> ImagefeatureakazeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeFrame::sum(self : ImagefeatureakazeFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeFrame::mean(self : ImagefeatureakazeFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeFrame::scale(self : ImagefeatureakazeFrame, f : Double) -> ImagefeatureakazeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeFrame::add(self : ImagefeatureakazeFrame, other : ImagefeatureakazeFrame) -> ImagefeatureakazeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeFrame::copy(self : ImagefeatureakazeFrame) -> ImagefeatureakazeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeFrame::fill(self : ImagefeatureakazeFrame, v : Double) -> ImagefeatureakazeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeFrame::min(self : ImagefeatureakazeFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeFrame::max(self : ImagefeatureakazeFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeFrame::to_string(self : ImagefeatureakazeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_table_make(size : Int) -> ImagefeatureakazeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeTable::len(self : ImagefeatureakazeTable) -> Int { self.size }

pub fn ImagefeatureakazeTable::get(self : ImagefeatureakazeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeTable::set(self : ImagefeatureakazeTable, i : Int, v : Double) -> ImagefeatureakazeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeTable::sum(self : ImagefeatureakazeTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeTable::mean(self : ImagefeatureakazeTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeTable::scale(self : ImagefeatureakazeTable, f : Double) -> ImagefeatureakazeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeTable::add(self : ImagefeatureakazeTable, other : ImagefeatureakazeTable) -> ImagefeatureakazeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeTable::copy(self : ImagefeatureakazeTable) -> ImagefeatureakazeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeTable::fill(self : ImagefeatureakazeTable, v : Double) -> ImagefeatureakazeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeTable::min(self : ImagefeatureakazeTable) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeTable::max(self : ImagefeatureakazeTable) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeTable::to_string(self : ImagefeatureakazeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_graphn_make(size : Int) -> ImagefeatureakazeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeGraphN::len(self : ImagefeatureakazeGraphN) -> Int { self.size }

pub fn ImagefeatureakazeGraphN::get(self : ImagefeatureakazeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeGraphN::set(self : ImagefeatureakazeGraphN, i : Int, v : Double) -> ImagefeatureakazeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeGraphN::sum(self : ImagefeatureakazeGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeGraphN::mean(self : ImagefeatureakazeGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeGraphN::scale(self : ImagefeatureakazeGraphN, f : Double) -> ImagefeatureakazeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeGraphN::add(self : ImagefeatureakazeGraphN, other : ImagefeatureakazeGraphN) -> ImagefeatureakazeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeGraphN::copy(self : ImagefeatureakazeGraphN) -> ImagefeatureakazeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeGraphN::fill(self : ImagefeatureakazeGraphN, v : Double) -> ImagefeatureakazeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeGraphN::min(self : ImagefeatureakazeGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeGraphN::max(self : ImagefeatureakazeGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeGraphN::to_string(self : ImagefeatureakazeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_node_make(size : Int) -> ImagefeatureakazeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeNode::len(self : ImagefeatureakazeNode) -> Int { self.size }

pub fn ImagefeatureakazeNode::get(self : ImagefeatureakazeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeNode::set(self : ImagefeatureakazeNode, i : Int, v : Double) -> ImagefeatureakazeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeNode::sum(self : ImagefeatureakazeNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeNode::mean(self : ImagefeatureakazeNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeNode::scale(self : ImagefeatureakazeNode, f : Double) -> ImagefeatureakazeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeNode::add(self : ImagefeatureakazeNode, other : ImagefeatureakazeNode) -> ImagefeatureakazeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeNode::copy(self : ImagefeatureakazeNode) -> ImagefeatureakazeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeNode::fill(self : ImagefeatureakazeNode, v : Double) -> ImagefeatureakazeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeNode::min(self : ImagefeatureakazeNode) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeNode::max(self : ImagefeatureakazeNode) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeNode::to_string(self : ImagefeatureakazeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_edge_make(size : Int) -> ImagefeatureakazeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeEdge::len(self : ImagefeatureakazeEdge) -> Int { self.size }

pub fn ImagefeatureakazeEdge::get(self : ImagefeatureakazeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeEdge::set(self : ImagefeatureakazeEdge, i : Int, v : Double) -> ImagefeatureakazeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeEdge::sum(self : ImagefeatureakazeEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeEdge::mean(self : ImagefeatureakazeEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeEdge::scale(self : ImagefeatureakazeEdge, f : Double) -> ImagefeatureakazeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeEdge::add(self : ImagefeatureakazeEdge, other : ImagefeatureakazeEdge) -> ImagefeatureakazeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeEdge::copy(self : ImagefeatureakazeEdge) -> ImagefeatureakazeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeEdge::fill(self : ImagefeatureakazeEdge, v : Double) -> ImagefeatureakazeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeEdge::min(self : ImagefeatureakazeEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeEdge::max(self : ImagefeatureakazeEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeEdge::to_string(self : ImagefeatureakazeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_path_make(size : Int) -> ImagefeatureakazePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazePath::len(self : ImagefeatureakazePath) -> Int { self.size }

pub fn ImagefeatureakazePath::get(self : ImagefeatureakazePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazePath::set(self : ImagefeatureakazePath, i : Int, v : Double) -> ImagefeatureakazePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazePath::sum(self : ImagefeatureakazePath) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazePath::mean(self : ImagefeatureakazePath) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazePath::scale(self : ImagefeatureakazePath, f : Double) -> ImagefeatureakazePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazePath::add(self : ImagefeatureakazePath, other : ImagefeatureakazePath) -> ImagefeatureakazePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazePath::copy(self : ImagefeatureakazePath) -> ImagefeatureakazePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazePath::fill(self : ImagefeatureakazePath, v : Double) -> ImagefeatureakazePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazePath::min(self : ImagefeatureakazePath) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazePath::max(self : ImagefeatureakazePath) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazePath::to_string(self : ImagefeatureakazePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_cluster_make(size : Int) -> ImagefeatureakazeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeCluster::len(self : ImagefeatureakazeCluster) -> Int { self.size }

pub fn ImagefeatureakazeCluster::get(self : ImagefeatureakazeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeCluster::set(self : ImagefeatureakazeCluster, i : Int, v : Double) -> ImagefeatureakazeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCluster::sum(self : ImagefeatureakazeCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeCluster::mean(self : ImagefeatureakazeCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeCluster::scale(self : ImagefeatureakazeCluster, f : Double) -> ImagefeatureakazeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCluster::add(self : ImagefeatureakazeCluster, other : ImagefeatureakazeCluster) -> ImagefeatureakazeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeCluster::copy(self : ImagefeatureakazeCluster) -> ImagefeatureakazeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCluster::fill(self : ImagefeatureakazeCluster, v : Double) -> ImagefeatureakazeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCluster::min(self : ImagefeatureakazeCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeCluster::max(self : ImagefeatureakazeCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeCluster::to_string(self : ImagefeatureakazeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_model_make(size : Int) -> ImagefeatureakazeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeModel::len(self : ImagefeatureakazeModel) -> Int { self.size }

pub fn ImagefeatureakazeModel::get(self : ImagefeatureakazeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeModel::set(self : ImagefeatureakazeModel, i : Int, v : Double) -> ImagefeatureakazeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeModel::sum(self : ImagefeatureakazeModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeModel::mean(self : ImagefeatureakazeModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeModel::scale(self : ImagefeatureakazeModel, f : Double) -> ImagefeatureakazeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeModel::add(self : ImagefeatureakazeModel, other : ImagefeatureakazeModel) -> ImagefeatureakazeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeModel::copy(self : ImagefeatureakazeModel) -> ImagefeatureakazeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeModel::fill(self : ImagefeatureakazeModel, v : Double) -> ImagefeatureakazeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeModel::min(self : ImagefeatureakazeModel) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeModel::max(self : ImagefeatureakazeModel) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeModel::to_string(self : ImagefeatureakazeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_layer_make(size : Int) -> ImagefeatureakazeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeLayer::len(self : ImagefeatureakazeLayer) -> Int { self.size }

pub fn ImagefeatureakazeLayer::get(self : ImagefeatureakazeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeLayer::set(self : ImagefeatureakazeLayer, i : Int, v : Double) -> ImagefeatureakazeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeLayer::sum(self : ImagefeatureakazeLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeLayer::mean(self : ImagefeatureakazeLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeLayer::scale(self : ImagefeatureakazeLayer, f : Double) -> ImagefeatureakazeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeLayer::add(self : ImagefeatureakazeLayer, other : ImagefeatureakazeLayer) -> ImagefeatureakazeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeLayer::copy(self : ImagefeatureakazeLayer) -> ImagefeatureakazeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeLayer::fill(self : ImagefeatureakazeLayer, v : Double) -> ImagefeatureakazeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeLayer::min(self : ImagefeatureakazeLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeLayer::max(self : ImagefeatureakazeLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeLayer::to_string(self : ImagefeatureakazeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_buffer_make(size : Int) -> ImagefeatureakazeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeBuffer::len(self : ImagefeatureakazeBuffer) -> Int { self.size }

pub fn ImagefeatureakazeBuffer::get(self : ImagefeatureakazeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeBuffer::set(self : ImagefeatureakazeBuffer, i : Int, v : Double) -> ImagefeatureakazeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeBuffer::sum(self : ImagefeatureakazeBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeBuffer::mean(self : ImagefeatureakazeBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeBuffer::scale(self : ImagefeatureakazeBuffer, f : Double) -> ImagefeatureakazeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeBuffer::add(self : ImagefeatureakazeBuffer, other : ImagefeatureakazeBuffer) -> ImagefeatureakazeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeBuffer::copy(self : ImagefeatureakazeBuffer) -> ImagefeatureakazeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeBuffer::fill(self : ImagefeatureakazeBuffer, v : Double) -> ImagefeatureakazeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeBuffer::min(self : ImagefeatureakazeBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeBuffer::max(self : ImagefeatureakazeBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeBuffer::to_string(self : ImagefeatureakazeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_cursor_make(size : Int) -> ImagefeatureakazeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeCursor::len(self : ImagefeatureakazeCursor) -> Int { self.size }

pub fn ImagefeatureakazeCursor::get(self : ImagefeatureakazeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeCursor::set(self : ImagefeatureakazeCursor, i : Int, v : Double) -> ImagefeatureakazeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCursor::sum(self : ImagefeatureakazeCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeCursor::mean(self : ImagefeatureakazeCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeCursor::scale(self : ImagefeatureakazeCursor, f : Double) -> ImagefeatureakazeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCursor::add(self : ImagefeatureakazeCursor, other : ImagefeatureakazeCursor) -> ImagefeatureakazeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeCursor::copy(self : ImagefeatureakazeCursor) -> ImagefeatureakazeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCursor::fill(self : ImagefeatureakazeCursor, v : Double) -> ImagefeatureakazeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeCursor::min(self : ImagefeatureakazeCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeCursor::max(self : ImagefeatureakazeCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeCursor::to_string(self : ImagefeatureakazeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_view_make(size : Int) -> ImagefeatureakazeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeView::len(self : ImagefeatureakazeView) -> Int { self.size }

pub fn ImagefeatureakazeView::get(self : ImagefeatureakazeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeView::set(self : ImagefeatureakazeView, i : Int, v : Double) -> ImagefeatureakazeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeView::sum(self : ImagefeatureakazeView) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeView::mean(self : ImagefeatureakazeView) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeView::scale(self : ImagefeatureakazeView, f : Double) -> ImagefeatureakazeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeView::add(self : ImagefeatureakazeView, other : ImagefeatureakazeView) -> ImagefeatureakazeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeView::copy(self : ImagefeatureakazeView) -> ImagefeatureakazeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeView::fill(self : ImagefeatureakazeView, v : Double) -> ImagefeatureakazeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeView::min(self : ImagefeatureakazeView) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeView::max(self : ImagefeatureakazeView) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeView::to_string(self : ImagefeatureakazeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_range_make(size : Int) -> ImagefeatureakazeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeRange::len(self : ImagefeatureakazeRange) -> Int { self.size }

pub fn ImagefeatureakazeRange::get(self : ImagefeatureakazeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeRange::set(self : ImagefeatureakazeRange, i : Int, v : Double) -> ImagefeatureakazeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeRange::sum(self : ImagefeatureakazeRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeRange::mean(self : ImagefeatureakazeRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeRange::scale(self : ImagefeatureakazeRange, f : Double) -> ImagefeatureakazeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeRange::add(self : ImagefeatureakazeRange, other : ImagefeatureakazeRange) -> ImagefeatureakazeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeRange::copy(self : ImagefeatureakazeRange) -> ImagefeatureakazeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeRange::fill(self : ImagefeatureakazeRange, v : Double) -> ImagefeatureakazeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeRange::min(self : ImagefeatureakazeRange) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeRange::max(self : ImagefeatureakazeRange) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeRange::to_string(self : ImagefeatureakazeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_slice_make(size : Int) -> ImagefeatureakazeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureakazeSlice::len(self : ImagefeatureakazeSlice) -> Int { self.size }

pub fn ImagefeatureakazeSlice::get(self : ImagefeatureakazeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureakazeSlice::set(self : ImagefeatureakazeSlice, i : Int, v : Double) -> ImagefeatureakazeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeSlice::sum(self : ImagefeatureakazeSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureakazeSlice::mean(self : ImagefeatureakazeSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureakazeSlice::scale(self : ImagefeatureakazeSlice, f : Double) -> ImagefeatureakazeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeSlice::add(self : ImagefeatureakazeSlice, other : ImagefeatureakazeSlice) -> ImagefeatureakazeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureakazeSlice::copy(self : ImagefeatureakazeSlice) -> ImagefeatureakazeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeSlice::fill(self : ImagefeatureakazeSlice, v : Double) -> ImagefeatureakazeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureakazeSlice::min(self : ImagefeatureakazeSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeatureakazeSlice::max(self : ImagefeatureakazeSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeatureakazeSlice::to_string(self : ImagefeatureakazeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

