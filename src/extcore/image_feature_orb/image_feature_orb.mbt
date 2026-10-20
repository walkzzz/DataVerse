///===
/// extcore/image_feature_orb

pub(all) struct ImagefeatureorbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_orb_make_point(x : Double, y : Double) -> ImagefeatureorbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_orb_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureorbPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeatureorbPoint::x(self : ImagefeatureorbPoint) -> Double { self.x }

pub fn ImagefeatureorbPoint::y(self : ImagefeatureorbPoint) -> Double { self.y }

pub fn ImagefeatureorbPoint::z(self : ImagefeatureorbPoint) -> Double { self.z }

pub fn ImagefeatureorbPoint::label(self : ImagefeatureorbPoint) -> Int { self.label }

pub fn ImagefeatureorbPoint::dist(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeatureorbPoint::add(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeatureorbPoint::sub(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeatureorbPoint::scale(self : ImagefeatureorbPoint, s : Double) -> ImagefeatureorbPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeatureorbPoint::dot(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeatureorbPoint::cross(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeatureorbPoint::norm(self : ImagefeatureorbPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeatureorbPoint::normalize(self : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureorbPoint::negate(self : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeatureorbPoint::mid(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeatureorbPoint::lerp(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint, t : Double) -> ImagefeatureorbPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeatureorbPoint::to_string(self : ImagefeatureorbPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeatureorbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_orb_make_series(vals : Array[Double], name : String) -> ImagefeatureorbSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeatureorbSeries::len(self : ImagefeatureorbSeries) -> Int { self.vals.length() }

pub fn ImagefeatureorbSeries::sum(self : ImagefeatureorbSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeatureorbSeries::mean(self : ImagefeatureorbSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeatureorbSeries::min(self : ImagefeatureorbSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeatureorbSeries::max(self : ImagefeatureorbSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeatureorbSeries::range(self : ImagefeatureorbSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeatureorbSeries::variance(self : ImagefeatureorbSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeatureorbSeries::std(self : ImagefeatureorbSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeatureorbSeries::median(self : ImagefeatureorbSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeatureorbSeries::scale(self : ImagefeatureorbSeries, f : Double) -> ImagefeatureorbSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeatureorbSeries::add(self : ImagefeatureorbSeries, other : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeatureorbSeries::sub(self : ImagefeatureorbSeries, other : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeatureorbSeries::normalize(self : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeatureorbSeries::cumsum(self : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeatureorbSeries::to_string(self : ImagefeatureorbSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureorbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_orb_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureorbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_orb_matrix_identity(n : Int) -> ImagefeatureorbMatrix {
  let m = image_feature_orb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeatureorbMatrix::get(self : ImagefeatureorbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeatureorbMatrix::transpose(self : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  let result = image_feature_orb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeatureorbMatrix::add(self : ImagefeatureorbMatrix, other : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_orb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeatureorbMatrix::scale(self : ImagefeatureorbMatrix, s : Double) -> ImagefeatureorbMatrix {
  let result = image_feature_orb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeatureorbMatrix::multiply(self : ImagefeatureorbMatrix, other : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  if self.cols != other.rows { return image_feature_orb_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_orb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefeatureorbMatrix::trace(self : ImagefeatureorbMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeatureorbMatrix::det(self : ImagefeatureorbMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeatureorbMatrix::norm(self : ImagefeatureorbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeatureorbMatrix::to_string(self : ImagefeatureorbMatrix) -> String {
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

pub(all) struct ImagefeatureorbVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_orb_make_vector(comps : Array[Double]) -> ImagefeatureorbVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_orb_vector_zero(dim : Int) -> ImagefeatureorbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeatureorbVector::add(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureorbVector::sub(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureorbVector::scale(self : ImagefeatureorbVector, s : Double) -> ImagefeatureorbVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeatureorbVector::dot(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeatureorbVector::norm(self : ImagefeatureorbVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeatureorbVector::normalize(self : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureorbVector::dist(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeatureorbVector::to_string(self : ImagefeatureorbVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureorbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_frame_make(size : Int) -> ImagefeatureorbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbFrame::len(self : ImagefeatureorbFrame) -> Int { self.size }

pub fn ImagefeatureorbFrame::get(self : ImagefeatureorbFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbFrame::set(self : ImagefeatureorbFrame, i : Int, v : Double) -> ImagefeatureorbFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbFrame::sum(self : ImagefeatureorbFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbFrame::mean(self : ImagefeatureorbFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbFrame::scale(self : ImagefeatureorbFrame, f : Double) -> ImagefeatureorbFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbFrame::add(self : ImagefeatureorbFrame, other : ImagefeatureorbFrame) -> ImagefeatureorbFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbFrame::copy(self : ImagefeatureorbFrame) -> ImagefeatureorbFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbFrame::fill(self : ImagefeatureorbFrame, v : Double) -> ImagefeatureorbFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbFrame::min(self : ImagefeatureorbFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbFrame::max(self : ImagefeatureorbFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbFrame::to_string(self : ImagefeatureorbFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_table_make(size : Int) -> ImagefeatureorbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbTable::len(self : ImagefeatureorbTable) -> Int { self.size }

pub fn ImagefeatureorbTable::get(self : ImagefeatureorbTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbTable::set(self : ImagefeatureorbTable, i : Int, v : Double) -> ImagefeatureorbTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbTable::sum(self : ImagefeatureorbTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbTable::mean(self : ImagefeatureorbTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbTable::scale(self : ImagefeatureorbTable, f : Double) -> ImagefeatureorbTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbTable::add(self : ImagefeatureorbTable, other : ImagefeatureorbTable) -> ImagefeatureorbTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbTable::copy(self : ImagefeatureorbTable) -> ImagefeatureorbTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbTable::fill(self : ImagefeatureorbTable, v : Double) -> ImagefeatureorbTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbTable::min(self : ImagefeatureorbTable) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbTable::max(self : ImagefeatureorbTable) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbTable::to_string(self : ImagefeatureorbTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_graphn_make(size : Int) -> ImagefeatureorbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbGraphN::len(self : ImagefeatureorbGraphN) -> Int { self.size }

pub fn ImagefeatureorbGraphN::get(self : ImagefeatureorbGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbGraphN::set(self : ImagefeatureorbGraphN, i : Int, v : Double) -> ImagefeatureorbGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbGraphN::sum(self : ImagefeatureorbGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbGraphN::mean(self : ImagefeatureorbGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbGraphN::scale(self : ImagefeatureorbGraphN, f : Double) -> ImagefeatureorbGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbGraphN::add(self : ImagefeatureorbGraphN, other : ImagefeatureorbGraphN) -> ImagefeatureorbGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbGraphN::copy(self : ImagefeatureorbGraphN) -> ImagefeatureorbGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbGraphN::fill(self : ImagefeatureorbGraphN, v : Double) -> ImagefeatureorbGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbGraphN::min(self : ImagefeatureorbGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbGraphN::max(self : ImagefeatureorbGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbGraphN::to_string(self : ImagefeatureorbGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_node_make(size : Int) -> ImagefeatureorbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbNode::len(self : ImagefeatureorbNode) -> Int { self.size }

pub fn ImagefeatureorbNode::get(self : ImagefeatureorbNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbNode::set(self : ImagefeatureorbNode, i : Int, v : Double) -> ImagefeatureorbNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbNode::sum(self : ImagefeatureorbNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbNode::mean(self : ImagefeatureorbNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbNode::scale(self : ImagefeatureorbNode, f : Double) -> ImagefeatureorbNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbNode::add(self : ImagefeatureorbNode, other : ImagefeatureorbNode) -> ImagefeatureorbNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbNode::copy(self : ImagefeatureorbNode) -> ImagefeatureorbNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbNode::fill(self : ImagefeatureorbNode, v : Double) -> ImagefeatureorbNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbNode::min(self : ImagefeatureorbNode) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbNode::max(self : ImagefeatureorbNode) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbNode::to_string(self : ImagefeatureorbNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_edge_make(size : Int) -> ImagefeatureorbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbEdge::len(self : ImagefeatureorbEdge) -> Int { self.size }

pub fn ImagefeatureorbEdge::get(self : ImagefeatureorbEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbEdge::set(self : ImagefeatureorbEdge, i : Int, v : Double) -> ImagefeatureorbEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbEdge::sum(self : ImagefeatureorbEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbEdge::mean(self : ImagefeatureorbEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbEdge::scale(self : ImagefeatureorbEdge, f : Double) -> ImagefeatureorbEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbEdge::add(self : ImagefeatureorbEdge, other : ImagefeatureorbEdge) -> ImagefeatureorbEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbEdge::copy(self : ImagefeatureorbEdge) -> ImagefeatureorbEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbEdge::fill(self : ImagefeatureorbEdge, v : Double) -> ImagefeatureorbEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbEdge::min(self : ImagefeatureorbEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbEdge::max(self : ImagefeatureorbEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbEdge::to_string(self : ImagefeatureorbEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_path_make(size : Int) -> ImagefeatureorbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbPath::len(self : ImagefeatureorbPath) -> Int { self.size }

pub fn ImagefeatureorbPath::get(self : ImagefeatureorbPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbPath::set(self : ImagefeatureorbPath, i : Int, v : Double) -> ImagefeatureorbPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbPath::sum(self : ImagefeatureorbPath) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbPath::mean(self : ImagefeatureorbPath) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbPath::scale(self : ImagefeatureorbPath, f : Double) -> ImagefeatureorbPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbPath::add(self : ImagefeatureorbPath, other : ImagefeatureorbPath) -> ImagefeatureorbPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbPath::copy(self : ImagefeatureorbPath) -> ImagefeatureorbPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbPath::fill(self : ImagefeatureorbPath, v : Double) -> ImagefeatureorbPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbPath::min(self : ImagefeatureorbPath) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbPath::max(self : ImagefeatureorbPath) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbPath::to_string(self : ImagefeatureorbPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_cluster_make(size : Int) -> ImagefeatureorbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbCluster::len(self : ImagefeatureorbCluster) -> Int { self.size }

pub fn ImagefeatureorbCluster::get(self : ImagefeatureorbCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbCluster::set(self : ImagefeatureorbCluster, i : Int, v : Double) -> ImagefeatureorbCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCluster::sum(self : ImagefeatureorbCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbCluster::mean(self : ImagefeatureorbCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbCluster::scale(self : ImagefeatureorbCluster, f : Double) -> ImagefeatureorbCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCluster::add(self : ImagefeatureorbCluster, other : ImagefeatureorbCluster) -> ImagefeatureorbCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbCluster::copy(self : ImagefeatureorbCluster) -> ImagefeatureorbCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCluster::fill(self : ImagefeatureorbCluster, v : Double) -> ImagefeatureorbCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCluster::min(self : ImagefeatureorbCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbCluster::max(self : ImagefeatureorbCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbCluster::to_string(self : ImagefeatureorbCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_model_make(size : Int) -> ImagefeatureorbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbModel::len(self : ImagefeatureorbModel) -> Int { self.size }

pub fn ImagefeatureorbModel::get(self : ImagefeatureorbModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbModel::set(self : ImagefeatureorbModel, i : Int, v : Double) -> ImagefeatureorbModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbModel::sum(self : ImagefeatureorbModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbModel::mean(self : ImagefeatureorbModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbModel::scale(self : ImagefeatureorbModel, f : Double) -> ImagefeatureorbModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbModel::add(self : ImagefeatureorbModel, other : ImagefeatureorbModel) -> ImagefeatureorbModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbModel::copy(self : ImagefeatureorbModel) -> ImagefeatureorbModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbModel::fill(self : ImagefeatureorbModel, v : Double) -> ImagefeatureorbModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbModel::min(self : ImagefeatureorbModel) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbModel::max(self : ImagefeatureorbModel) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbModel::to_string(self : ImagefeatureorbModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_layer_make(size : Int) -> ImagefeatureorbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbLayer::len(self : ImagefeatureorbLayer) -> Int { self.size }

pub fn ImagefeatureorbLayer::get(self : ImagefeatureorbLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbLayer::set(self : ImagefeatureorbLayer, i : Int, v : Double) -> ImagefeatureorbLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbLayer::sum(self : ImagefeatureorbLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbLayer::mean(self : ImagefeatureorbLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbLayer::scale(self : ImagefeatureorbLayer, f : Double) -> ImagefeatureorbLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbLayer::add(self : ImagefeatureorbLayer, other : ImagefeatureorbLayer) -> ImagefeatureorbLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbLayer::copy(self : ImagefeatureorbLayer) -> ImagefeatureorbLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbLayer::fill(self : ImagefeatureorbLayer, v : Double) -> ImagefeatureorbLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbLayer::min(self : ImagefeatureorbLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbLayer::max(self : ImagefeatureorbLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbLayer::to_string(self : ImagefeatureorbLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_buffer_make(size : Int) -> ImagefeatureorbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbBuffer::len(self : ImagefeatureorbBuffer) -> Int { self.size }

pub fn ImagefeatureorbBuffer::get(self : ImagefeatureorbBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbBuffer::set(self : ImagefeatureorbBuffer, i : Int, v : Double) -> ImagefeatureorbBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbBuffer::sum(self : ImagefeatureorbBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbBuffer::mean(self : ImagefeatureorbBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbBuffer::scale(self : ImagefeatureorbBuffer, f : Double) -> ImagefeatureorbBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbBuffer::add(self : ImagefeatureorbBuffer, other : ImagefeatureorbBuffer) -> ImagefeatureorbBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbBuffer::copy(self : ImagefeatureorbBuffer) -> ImagefeatureorbBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbBuffer::fill(self : ImagefeatureorbBuffer, v : Double) -> ImagefeatureorbBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbBuffer::min(self : ImagefeatureorbBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbBuffer::max(self : ImagefeatureorbBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbBuffer::to_string(self : ImagefeatureorbBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_cursor_make(size : Int) -> ImagefeatureorbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbCursor::len(self : ImagefeatureorbCursor) -> Int { self.size }

pub fn ImagefeatureorbCursor::get(self : ImagefeatureorbCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbCursor::set(self : ImagefeatureorbCursor, i : Int, v : Double) -> ImagefeatureorbCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCursor::sum(self : ImagefeatureorbCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbCursor::mean(self : ImagefeatureorbCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbCursor::scale(self : ImagefeatureorbCursor, f : Double) -> ImagefeatureorbCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCursor::add(self : ImagefeatureorbCursor, other : ImagefeatureorbCursor) -> ImagefeatureorbCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbCursor::copy(self : ImagefeatureorbCursor) -> ImagefeatureorbCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCursor::fill(self : ImagefeatureorbCursor, v : Double) -> ImagefeatureorbCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbCursor::min(self : ImagefeatureorbCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbCursor::max(self : ImagefeatureorbCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbCursor::to_string(self : ImagefeatureorbCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_view_make(size : Int) -> ImagefeatureorbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbView::len(self : ImagefeatureorbView) -> Int { self.size }

pub fn ImagefeatureorbView::get(self : ImagefeatureorbView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbView::set(self : ImagefeatureorbView, i : Int, v : Double) -> ImagefeatureorbView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbView::sum(self : ImagefeatureorbView) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbView::mean(self : ImagefeatureorbView) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbView::scale(self : ImagefeatureorbView, f : Double) -> ImagefeatureorbView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbView::add(self : ImagefeatureorbView, other : ImagefeatureorbView) -> ImagefeatureorbView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbView::copy(self : ImagefeatureorbView) -> ImagefeatureorbView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbView::fill(self : ImagefeatureorbView, v : Double) -> ImagefeatureorbView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbView::min(self : ImagefeatureorbView) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbView::max(self : ImagefeatureorbView) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbView::to_string(self : ImagefeatureorbView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_range_make(size : Int) -> ImagefeatureorbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbRange::len(self : ImagefeatureorbRange) -> Int { self.size }

pub fn ImagefeatureorbRange::get(self : ImagefeatureorbRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbRange::set(self : ImagefeatureorbRange, i : Int, v : Double) -> ImagefeatureorbRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbRange::sum(self : ImagefeatureorbRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbRange::mean(self : ImagefeatureorbRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbRange::scale(self : ImagefeatureorbRange, f : Double) -> ImagefeatureorbRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbRange::add(self : ImagefeatureorbRange, other : ImagefeatureorbRange) -> ImagefeatureorbRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbRange::copy(self : ImagefeatureorbRange) -> ImagefeatureorbRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbRange::fill(self : ImagefeatureorbRange, v : Double) -> ImagefeatureorbRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbRange::min(self : ImagefeatureorbRange) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbRange::max(self : ImagefeatureorbRange) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbRange::to_string(self : ImagefeatureorbRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_slice_make(size : Int) -> ImagefeatureorbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureorbSlice::len(self : ImagefeatureorbSlice) -> Int { self.size }

pub fn ImagefeatureorbSlice::get(self : ImagefeatureorbSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureorbSlice::set(self : ImagefeatureorbSlice, i : Int, v : Double) -> ImagefeatureorbSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbSlice::sum(self : ImagefeatureorbSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureorbSlice::mean(self : ImagefeatureorbSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureorbSlice::scale(self : ImagefeatureorbSlice, f : Double) -> ImagefeatureorbSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbSlice::add(self : ImagefeatureorbSlice, other : ImagefeatureorbSlice) -> ImagefeatureorbSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureorbSlice::copy(self : ImagefeatureorbSlice) -> ImagefeatureorbSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbSlice::fill(self : ImagefeatureorbSlice, v : Double) -> ImagefeatureorbSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureorbSlice::min(self : ImagefeatureorbSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeatureorbSlice::max(self : ImagefeatureorbSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeatureorbSlice::to_string(self : ImagefeatureorbSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

