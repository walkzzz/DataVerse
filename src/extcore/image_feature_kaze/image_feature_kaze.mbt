///===
/// extcore/image_feature_kaze

pub(all) struct ImagefeaturekazePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_kaze_make_point(x : Double, y : Double) -> ImagefeaturekazePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_kaze_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturekazePoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturekazePoint::x(self : ImagefeaturekazePoint) -> Double { self.x }

pub fn ImagefeaturekazePoint::y(self : ImagefeaturekazePoint) -> Double { self.y }

pub fn ImagefeaturekazePoint::z(self : ImagefeaturekazePoint) -> Double { self.z }

pub fn ImagefeaturekazePoint::label(self : ImagefeaturekazePoint) -> Int { self.label }

pub fn ImagefeaturekazePoint::dist(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturekazePoint::add(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturekazePoint::sub(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturekazePoint::scale(self : ImagefeaturekazePoint, s : Double) -> ImagefeaturekazePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturekazePoint::dot(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturekazePoint::cross(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturekazePoint::norm(self : ImagefeaturekazePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturekazePoint::normalize(self : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturekazePoint::negate(self : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturekazePoint::mid(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturekazePoint::lerp(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint, t : Double) -> ImagefeaturekazePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturekazePoint::to_string(self : ImagefeaturekazePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturekazeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_kaze_make_series(vals : Array[Double], name : String) -> ImagefeaturekazeSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturekazeSeries::len(self : ImagefeaturekazeSeries) -> Int { self.vals.length() }

pub fn ImagefeaturekazeSeries::sum(self : ImagefeaturekazeSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturekazeSeries::mean(self : ImagefeaturekazeSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturekazeSeries::min(self : ImagefeaturekazeSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturekazeSeries::max(self : ImagefeaturekazeSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturekazeSeries::range(self : ImagefeaturekazeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturekazeSeries::variance(self : ImagefeaturekazeSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturekazeSeries::std(self : ImagefeaturekazeSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturekazeSeries::median(self : ImagefeaturekazeSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturekazeSeries::scale(self : ImagefeaturekazeSeries, f : Double) -> ImagefeaturekazeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturekazeSeries::add(self : ImagefeaturekazeSeries, other : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturekazeSeries::sub(self : ImagefeaturekazeSeries, other : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturekazeSeries::normalize(self : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturekazeSeries::cumsum(self : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturekazeSeries::to_string(self : ImagefeaturekazeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturekazeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_kaze_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturekazeMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_feature_kaze_matrix_identity(n : Int) -> ImagefeaturekazeMatrix {
  let m = image_feature_kaze_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturekazeMatrix::get(self : ImagefeaturekazeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturekazeMatrix::transpose(self : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  let result = image_feature_kaze_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturekazeMatrix::add(self : ImagefeaturekazeMatrix, other : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_kaze_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturekazeMatrix::scale(self : ImagefeaturekazeMatrix, s : Double) -> ImagefeaturekazeMatrix {
  let result = image_feature_kaze_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturekazeMatrix::multiply(self : ImagefeaturekazeMatrix, other : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  if self.cols != other.rows { return image_feature_kaze_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_kaze_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefeaturekazeMatrix::trace(self : ImagefeaturekazeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturekazeMatrix::det(self : ImagefeaturekazeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturekazeMatrix::norm(self : ImagefeaturekazeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturekazeMatrix::to_string(self : ImagefeaturekazeMatrix) -> String {
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

pub(all) struct ImagefeaturekazeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_kaze_make_vector(comps : Array[Double]) -> ImagefeaturekazeVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_kaze_vector_zero(dim : Int) -> ImagefeaturekazeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturekazeVector::add(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturekazeVector::sub(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturekazeVector::scale(self : ImagefeaturekazeVector, s : Double) -> ImagefeaturekazeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturekazeVector::dot(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturekazeVector::norm(self : ImagefeaturekazeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturekazeVector::normalize(self : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturekazeVector::dist(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturekazeVector::to_string(self : ImagefeaturekazeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturekazeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_frame_make(size : Int) -> ImagefeaturekazeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeFrame::len(self : ImagefeaturekazeFrame) -> Int { self.size }

pub fn ImagefeaturekazeFrame::get(self : ImagefeaturekazeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeFrame::set(self : ImagefeaturekazeFrame, i : Int, v : Double) -> ImagefeaturekazeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeFrame::sum(self : ImagefeaturekazeFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeFrame::mean(self : ImagefeaturekazeFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeFrame::scale(self : ImagefeaturekazeFrame, f : Double) -> ImagefeaturekazeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeFrame::add(self : ImagefeaturekazeFrame, other : ImagefeaturekazeFrame) -> ImagefeaturekazeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeFrame::copy(self : ImagefeaturekazeFrame) -> ImagefeaturekazeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeFrame::fill(self : ImagefeaturekazeFrame, v : Double) -> ImagefeaturekazeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeFrame::min(self : ImagefeaturekazeFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeFrame::max(self : ImagefeaturekazeFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeFrame::to_string(self : ImagefeaturekazeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_table_make(size : Int) -> ImagefeaturekazeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeTable::len(self : ImagefeaturekazeTable) -> Int { self.size }

pub fn ImagefeaturekazeTable::get(self : ImagefeaturekazeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeTable::set(self : ImagefeaturekazeTable, i : Int, v : Double) -> ImagefeaturekazeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeTable::sum(self : ImagefeaturekazeTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeTable::mean(self : ImagefeaturekazeTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeTable::scale(self : ImagefeaturekazeTable, f : Double) -> ImagefeaturekazeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeTable::add(self : ImagefeaturekazeTable, other : ImagefeaturekazeTable) -> ImagefeaturekazeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeTable::copy(self : ImagefeaturekazeTable) -> ImagefeaturekazeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeTable::fill(self : ImagefeaturekazeTable, v : Double) -> ImagefeaturekazeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeTable::min(self : ImagefeaturekazeTable) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeTable::max(self : ImagefeaturekazeTable) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeTable::to_string(self : ImagefeaturekazeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_graphn_make(size : Int) -> ImagefeaturekazeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeGraphN::len(self : ImagefeaturekazeGraphN) -> Int { self.size }

pub fn ImagefeaturekazeGraphN::get(self : ImagefeaturekazeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeGraphN::set(self : ImagefeaturekazeGraphN, i : Int, v : Double) -> ImagefeaturekazeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeGraphN::sum(self : ImagefeaturekazeGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeGraphN::mean(self : ImagefeaturekazeGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeGraphN::scale(self : ImagefeaturekazeGraphN, f : Double) -> ImagefeaturekazeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeGraphN::add(self : ImagefeaturekazeGraphN, other : ImagefeaturekazeGraphN) -> ImagefeaturekazeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeGraphN::copy(self : ImagefeaturekazeGraphN) -> ImagefeaturekazeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeGraphN::fill(self : ImagefeaturekazeGraphN, v : Double) -> ImagefeaturekazeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeGraphN::min(self : ImagefeaturekazeGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeGraphN::max(self : ImagefeaturekazeGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeGraphN::to_string(self : ImagefeaturekazeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_node_make(size : Int) -> ImagefeaturekazeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeNode::len(self : ImagefeaturekazeNode) -> Int { self.size }

pub fn ImagefeaturekazeNode::get(self : ImagefeaturekazeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeNode::set(self : ImagefeaturekazeNode, i : Int, v : Double) -> ImagefeaturekazeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeNode::sum(self : ImagefeaturekazeNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeNode::mean(self : ImagefeaturekazeNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeNode::scale(self : ImagefeaturekazeNode, f : Double) -> ImagefeaturekazeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeNode::add(self : ImagefeaturekazeNode, other : ImagefeaturekazeNode) -> ImagefeaturekazeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeNode::copy(self : ImagefeaturekazeNode) -> ImagefeaturekazeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeNode::fill(self : ImagefeaturekazeNode, v : Double) -> ImagefeaturekazeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeNode::min(self : ImagefeaturekazeNode) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeNode::max(self : ImagefeaturekazeNode) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeNode::to_string(self : ImagefeaturekazeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_edge_make(size : Int) -> ImagefeaturekazeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeEdge::len(self : ImagefeaturekazeEdge) -> Int { self.size }

pub fn ImagefeaturekazeEdge::get(self : ImagefeaturekazeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeEdge::set(self : ImagefeaturekazeEdge, i : Int, v : Double) -> ImagefeaturekazeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeEdge::sum(self : ImagefeaturekazeEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeEdge::mean(self : ImagefeaturekazeEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeEdge::scale(self : ImagefeaturekazeEdge, f : Double) -> ImagefeaturekazeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeEdge::add(self : ImagefeaturekazeEdge, other : ImagefeaturekazeEdge) -> ImagefeaturekazeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeEdge::copy(self : ImagefeaturekazeEdge) -> ImagefeaturekazeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeEdge::fill(self : ImagefeaturekazeEdge, v : Double) -> ImagefeaturekazeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeEdge::min(self : ImagefeaturekazeEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeEdge::max(self : ImagefeaturekazeEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeEdge::to_string(self : ImagefeaturekazeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_path_make(size : Int) -> ImagefeaturekazePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazePath::len(self : ImagefeaturekazePath) -> Int { self.size }

pub fn ImagefeaturekazePath::get(self : ImagefeaturekazePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazePath::set(self : ImagefeaturekazePath, i : Int, v : Double) -> ImagefeaturekazePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazePath::sum(self : ImagefeaturekazePath) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazePath::mean(self : ImagefeaturekazePath) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazePath::scale(self : ImagefeaturekazePath, f : Double) -> ImagefeaturekazePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazePath::add(self : ImagefeaturekazePath, other : ImagefeaturekazePath) -> ImagefeaturekazePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazePath::copy(self : ImagefeaturekazePath) -> ImagefeaturekazePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazePath::fill(self : ImagefeaturekazePath, v : Double) -> ImagefeaturekazePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazePath::min(self : ImagefeaturekazePath) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazePath::max(self : ImagefeaturekazePath) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazePath::to_string(self : ImagefeaturekazePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_cluster_make(size : Int) -> ImagefeaturekazeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeCluster::len(self : ImagefeaturekazeCluster) -> Int { self.size }

pub fn ImagefeaturekazeCluster::get(self : ImagefeaturekazeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeCluster::set(self : ImagefeaturekazeCluster, i : Int, v : Double) -> ImagefeaturekazeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCluster::sum(self : ImagefeaturekazeCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeCluster::mean(self : ImagefeaturekazeCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeCluster::scale(self : ImagefeaturekazeCluster, f : Double) -> ImagefeaturekazeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCluster::add(self : ImagefeaturekazeCluster, other : ImagefeaturekazeCluster) -> ImagefeaturekazeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeCluster::copy(self : ImagefeaturekazeCluster) -> ImagefeaturekazeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCluster::fill(self : ImagefeaturekazeCluster, v : Double) -> ImagefeaturekazeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCluster::min(self : ImagefeaturekazeCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeCluster::max(self : ImagefeaturekazeCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeCluster::to_string(self : ImagefeaturekazeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_model_make(size : Int) -> ImagefeaturekazeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeModel::len(self : ImagefeaturekazeModel) -> Int { self.size }

pub fn ImagefeaturekazeModel::get(self : ImagefeaturekazeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeModel::set(self : ImagefeaturekazeModel, i : Int, v : Double) -> ImagefeaturekazeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeModel::sum(self : ImagefeaturekazeModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeModel::mean(self : ImagefeaturekazeModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeModel::scale(self : ImagefeaturekazeModel, f : Double) -> ImagefeaturekazeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeModel::add(self : ImagefeaturekazeModel, other : ImagefeaturekazeModel) -> ImagefeaturekazeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeModel::copy(self : ImagefeaturekazeModel) -> ImagefeaturekazeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeModel::fill(self : ImagefeaturekazeModel, v : Double) -> ImagefeaturekazeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeModel::min(self : ImagefeaturekazeModel) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeModel::max(self : ImagefeaturekazeModel) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeModel::to_string(self : ImagefeaturekazeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_layer_make(size : Int) -> ImagefeaturekazeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeLayer::len(self : ImagefeaturekazeLayer) -> Int { self.size }

pub fn ImagefeaturekazeLayer::get(self : ImagefeaturekazeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeLayer::set(self : ImagefeaturekazeLayer, i : Int, v : Double) -> ImagefeaturekazeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeLayer::sum(self : ImagefeaturekazeLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeLayer::mean(self : ImagefeaturekazeLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeLayer::scale(self : ImagefeaturekazeLayer, f : Double) -> ImagefeaturekazeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeLayer::add(self : ImagefeaturekazeLayer, other : ImagefeaturekazeLayer) -> ImagefeaturekazeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeLayer::copy(self : ImagefeaturekazeLayer) -> ImagefeaturekazeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeLayer::fill(self : ImagefeaturekazeLayer, v : Double) -> ImagefeaturekazeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeLayer::min(self : ImagefeaturekazeLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeLayer::max(self : ImagefeaturekazeLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeLayer::to_string(self : ImagefeaturekazeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_buffer_make(size : Int) -> ImagefeaturekazeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeBuffer::len(self : ImagefeaturekazeBuffer) -> Int { self.size }

pub fn ImagefeaturekazeBuffer::get(self : ImagefeaturekazeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeBuffer::set(self : ImagefeaturekazeBuffer, i : Int, v : Double) -> ImagefeaturekazeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeBuffer::sum(self : ImagefeaturekazeBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeBuffer::mean(self : ImagefeaturekazeBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeBuffer::scale(self : ImagefeaturekazeBuffer, f : Double) -> ImagefeaturekazeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeBuffer::add(self : ImagefeaturekazeBuffer, other : ImagefeaturekazeBuffer) -> ImagefeaturekazeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeBuffer::copy(self : ImagefeaturekazeBuffer) -> ImagefeaturekazeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeBuffer::fill(self : ImagefeaturekazeBuffer, v : Double) -> ImagefeaturekazeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeBuffer::min(self : ImagefeaturekazeBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeBuffer::max(self : ImagefeaturekazeBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeBuffer::to_string(self : ImagefeaturekazeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_cursor_make(size : Int) -> ImagefeaturekazeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeCursor::len(self : ImagefeaturekazeCursor) -> Int { self.size }

pub fn ImagefeaturekazeCursor::get(self : ImagefeaturekazeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeCursor::set(self : ImagefeaturekazeCursor, i : Int, v : Double) -> ImagefeaturekazeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCursor::sum(self : ImagefeaturekazeCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeCursor::mean(self : ImagefeaturekazeCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeCursor::scale(self : ImagefeaturekazeCursor, f : Double) -> ImagefeaturekazeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCursor::add(self : ImagefeaturekazeCursor, other : ImagefeaturekazeCursor) -> ImagefeaturekazeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeCursor::copy(self : ImagefeaturekazeCursor) -> ImagefeaturekazeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCursor::fill(self : ImagefeaturekazeCursor, v : Double) -> ImagefeaturekazeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeCursor::min(self : ImagefeaturekazeCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeCursor::max(self : ImagefeaturekazeCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeCursor::to_string(self : ImagefeaturekazeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_view_make(size : Int) -> ImagefeaturekazeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeView::len(self : ImagefeaturekazeView) -> Int { self.size }

pub fn ImagefeaturekazeView::get(self : ImagefeaturekazeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeView::set(self : ImagefeaturekazeView, i : Int, v : Double) -> ImagefeaturekazeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeView::sum(self : ImagefeaturekazeView) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeView::mean(self : ImagefeaturekazeView) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeView::scale(self : ImagefeaturekazeView, f : Double) -> ImagefeaturekazeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeView::add(self : ImagefeaturekazeView, other : ImagefeaturekazeView) -> ImagefeaturekazeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeView::copy(self : ImagefeaturekazeView) -> ImagefeaturekazeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeView::fill(self : ImagefeaturekazeView, v : Double) -> ImagefeaturekazeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeView::min(self : ImagefeaturekazeView) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeView::max(self : ImagefeaturekazeView) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeView::to_string(self : ImagefeaturekazeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_range_make(size : Int) -> ImagefeaturekazeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeRange::len(self : ImagefeaturekazeRange) -> Int { self.size }

pub fn ImagefeaturekazeRange::get(self : ImagefeaturekazeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeRange::set(self : ImagefeaturekazeRange, i : Int, v : Double) -> ImagefeaturekazeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeRange::sum(self : ImagefeaturekazeRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeRange::mean(self : ImagefeaturekazeRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeRange::scale(self : ImagefeaturekazeRange, f : Double) -> ImagefeaturekazeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeRange::add(self : ImagefeaturekazeRange, other : ImagefeaturekazeRange) -> ImagefeaturekazeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeRange::copy(self : ImagefeaturekazeRange) -> ImagefeaturekazeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeRange::fill(self : ImagefeaturekazeRange, v : Double) -> ImagefeaturekazeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeRange::min(self : ImagefeaturekazeRange) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeRange::max(self : ImagefeaturekazeRange) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeRange::to_string(self : ImagefeaturekazeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_slice_make(size : Int) -> ImagefeaturekazeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturekazeSlice::len(self : ImagefeaturekazeSlice) -> Int { self.size }

pub fn ImagefeaturekazeSlice::get(self : ImagefeaturekazeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturekazeSlice::set(self : ImagefeaturekazeSlice, i : Int, v : Double) -> ImagefeaturekazeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeSlice::sum(self : ImagefeaturekazeSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturekazeSlice::mean(self : ImagefeaturekazeSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturekazeSlice::scale(self : ImagefeaturekazeSlice, f : Double) -> ImagefeaturekazeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeSlice::add(self : ImagefeaturekazeSlice, other : ImagefeaturekazeSlice) -> ImagefeaturekazeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturekazeSlice::copy(self : ImagefeaturekazeSlice) -> ImagefeaturekazeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeSlice::fill(self : ImagefeaturekazeSlice, v : Double) -> ImagefeaturekazeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturekazeSlice::min(self : ImagefeaturekazeSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeaturekazeSlice::max(self : ImagefeaturekazeSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeaturekazeSlice::to_string(self : ImagefeaturekazeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

