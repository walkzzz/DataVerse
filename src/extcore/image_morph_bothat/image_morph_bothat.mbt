///===
/// extcore/image_morph_bothat

pub(all) struct ImagemorphbothatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_bothat_make_point(x : Double, y : Double) -> ImagemorphbothatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_bothat_make_point3(x : Double, y : Double, z : Double) -> ImagemorphbothatPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphbothatPoint::x(self : ImagemorphbothatPoint) -> Double { self.x }

pub fn ImagemorphbothatPoint::y(self : ImagemorphbothatPoint) -> Double { self.y }

pub fn ImagemorphbothatPoint::z(self : ImagemorphbothatPoint) -> Double { self.z }

pub fn ImagemorphbothatPoint::label(self : ImagemorphbothatPoint) -> Int { self.label }

pub fn ImagemorphbothatPoint::dist(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphbothatPoint::add(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphbothatPoint::sub(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphbothatPoint::scale(self : ImagemorphbothatPoint, s : Double) -> ImagemorphbothatPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphbothatPoint::dot(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphbothatPoint::cross(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphbothatPoint::norm(self : ImagemorphbothatPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphbothatPoint::normalize(self : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphbothatPoint::negate(self : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphbothatPoint::mid(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphbothatPoint::lerp(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint, t : Double) -> ImagemorphbothatPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphbothatPoint::to_string(self : ImagemorphbothatPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphbothatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_bothat_make_series(vals : Array[Double], name : String) -> ImagemorphbothatSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphbothatSeries::len(self : ImagemorphbothatSeries) -> Int { self.vals.length() }

pub fn ImagemorphbothatSeries::sum(self : ImagemorphbothatSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphbothatSeries::mean(self : ImagemorphbothatSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphbothatSeries::min(self : ImagemorphbothatSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphbothatSeries::max(self : ImagemorphbothatSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphbothatSeries::range(self : ImagemorphbothatSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphbothatSeries::variance(self : ImagemorphbothatSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphbothatSeries::std(self : ImagemorphbothatSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphbothatSeries::median(self : ImagemorphbothatSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphbothatSeries::scale(self : ImagemorphbothatSeries, f : Double) -> ImagemorphbothatSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphbothatSeries::add(self : ImagemorphbothatSeries, other : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphbothatSeries::sub(self : ImagemorphbothatSeries, other : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphbothatSeries::normalize(self : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphbothatSeries::cumsum(self : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphbothatSeries::to_string(self : ImagemorphbothatSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphbothatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_bothat_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphbothatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_bothat_matrix_identity(n : Int) -> ImagemorphbothatMatrix {
  let m = image_morph_bothat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphbothatMatrix::get(self : ImagemorphbothatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphbothatMatrix::transpose(self : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  let result = image_morph_bothat_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphbothatMatrix::add(self : ImagemorphbothatMatrix, other : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_bothat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphbothatMatrix::scale(self : ImagemorphbothatMatrix, s : Double) -> ImagemorphbothatMatrix {
  let result = image_morph_bothat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphbothatMatrix::multiply(self : ImagemorphbothatMatrix, other : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  if self.cols != other.rows { return image_morph_bothat_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_bothat_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphbothatMatrix::trace(self : ImagemorphbothatMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphbothatMatrix::det(self : ImagemorphbothatMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphbothatMatrix::norm(self : ImagemorphbothatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphbothatMatrix::to_string(self : ImagemorphbothatMatrix) -> String {
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

pub(all) struct ImagemorphbothatVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_bothat_make_vector(comps : Array[Double]) -> ImagemorphbothatVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_bothat_vector_zero(dim : Int) -> ImagemorphbothatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphbothatVector::add(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphbothatVector::sub(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphbothatVector::scale(self : ImagemorphbothatVector, s : Double) -> ImagemorphbothatVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphbothatVector::dot(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphbothatVector::norm(self : ImagemorphbothatVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphbothatVector::normalize(self : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphbothatVector::dist(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphbothatVector::to_string(self : ImagemorphbothatVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphbothatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_frame_make(size : Int) -> ImagemorphbothatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatFrame::len(self : ImagemorphbothatFrame) -> Int { self.size }

pub fn ImagemorphbothatFrame::get(self : ImagemorphbothatFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatFrame::set(self : ImagemorphbothatFrame, i : Int, v : Double) -> ImagemorphbothatFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatFrame::sum(self : ImagemorphbothatFrame) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatFrame::mean(self : ImagemorphbothatFrame) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatFrame::scale(self : ImagemorphbothatFrame, f : Double) -> ImagemorphbothatFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatFrame::add(self : ImagemorphbothatFrame, other : ImagemorphbothatFrame) -> ImagemorphbothatFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatFrame::copy(self : ImagemorphbothatFrame) -> ImagemorphbothatFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatFrame::fill(self : ImagemorphbothatFrame, v : Double) -> ImagemorphbothatFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatFrame::min(self : ImagemorphbothatFrame) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatFrame::max(self : ImagemorphbothatFrame) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatFrame::to_string(self : ImagemorphbothatFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_table_make(size : Int) -> ImagemorphbothatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatTable::len(self : ImagemorphbothatTable) -> Int { self.size }

pub fn ImagemorphbothatTable::get(self : ImagemorphbothatTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatTable::set(self : ImagemorphbothatTable, i : Int, v : Double) -> ImagemorphbothatTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatTable::sum(self : ImagemorphbothatTable) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatTable::mean(self : ImagemorphbothatTable) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatTable::scale(self : ImagemorphbothatTable, f : Double) -> ImagemorphbothatTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatTable::add(self : ImagemorphbothatTable, other : ImagemorphbothatTable) -> ImagemorphbothatTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatTable::copy(self : ImagemorphbothatTable) -> ImagemorphbothatTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatTable::fill(self : ImagemorphbothatTable, v : Double) -> ImagemorphbothatTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatTable::min(self : ImagemorphbothatTable) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatTable::max(self : ImagemorphbothatTable) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatTable::to_string(self : ImagemorphbothatTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_graphn_make(size : Int) -> ImagemorphbothatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatGraphN::len(self : ImagemorphbothatGraphN) -> Int { self.size }

pub fn ImagemorphbothatGraphN::get(self : ImagemorphbothatGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatGraphN::set(self : ImagemorphbothatGraphN, i : Int, v : Double) -> ImagemorphbothatGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatGraphN::sum(self : ImagemorphbothatGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatGraphN::mean(self : ImagemorphbothatGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatGraphN::scale(self : ImagemorphbothatGraphN, f : Double) -> ImagemorphbothatGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatGraphN::add(self : ImagemorphbothatGraphN, other : ImagemorphbothatGraphN) -> ImagemorphbothatGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatGraphN::copy(self : ImagemorphbothatGraphN) -> ImagemorphbothatGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatGraphN::fill(self : ImagemorphbothatGraphN, v : Double) -> ImagemorphbothatGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatGraphN::min(self : ImagemorphbothatGraphN) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatGraphN::max(self : ImagemorphbothatGraphN) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatGraphN::to_string(self : ImagemorphbothatGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_node_make(size : Int) -> ImagemorphbothatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatNode::len(self : ImagemorphbothatNode) -> Int { self.size }

pub fn ImagemorphbothatNode::get(self : ImagemorphbothatNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatNode::set(self : ImagemorphbothatNode, i : Int, v : Double) -> ImagemorphbothatNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatNode::sum(self : ImagemorphbothatNode) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatNode::mean(self : ImagemorphbothatNode) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatNode::scale(self : ImagemorphbothatNode, f : Double) -> ImagemorphbothatNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatNode::add(self : ImagemorphbothatNode, other : ImagemorphbothatNode) -> ImagemorphbothatNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatNode::copy(self : ImagemorphbothatNode) -> ImagemorphbothatNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatNode::fill(self : ImagemorphbothatNode, v : Double) -> ImagemorphbothatNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatNode::min(self : ImagemorphbothatNode) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatNode::max(self : ImagemorphbothatNode) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatNode::to_string(self : ImagemorphbothatNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_edge_make(size : Int) -> ImagemorphbothatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatEdge::len(self : ImagemorphbothatEdge) -> Int { self.size }

pub fn ImagemorphbothatEdge::get(self : ImagemorphbothatEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatEdge::set(self : ImagemorphbothatEdge, i : Int, v : Double) -> ImagemorphbothatEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatEdge::sum(self : ImagemorphbothatEdge) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatEdge::mean(self : ImagemorphbothatEdge) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatEdge::scale(self : ImagemorphbothatEdge, f : Double) -> ImagemorphbothatEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatEdge::add(self : ImagemorphbothatEdge, other : ImagemorphbothatEdge) -> ImagemorphbothatEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatEdge::copy(self : ImagemorphbothatEdge) -> ImagemorphbothatEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatEdge::fill(self : ImagemorphbothatEdge, v : Double) -> ImagemorphbothatEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatEdge::min(self : ImagemorphbothatEdge) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatEdge::max(self : ImagemorphbothatEdge) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatEdge::to_string(self : ImagemorphbothatEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_path_make(size : Int) -> ImagemorphbothatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatPath::len(self : ImagemorphbothatPath) -> Int { self.size }

pub fn ImagemorphbothatPath::get(self : ImagemorphbothatPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatPath::set(self : ImagemorphbothatPath, i : Int, v : Double) -> ImagemorphbothatPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatPath::sum(self : ImagemorphbothatPath) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatPath::mean(self : ImagemorphbothatPath) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatPath::scale(self : ImagemorphbothatPath, f : Double) -> ImagemorphbothatPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatPath::add(self : ImagemorphbothatPath, other : ImagemorphbothatPath) -> ImagemorphbothatPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatPath::copy(self : ImagemorphbothatPath) -> ImagemorphbothatPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatPath::fill(self : ImagemorphbothatPath, v : Double) -> ImagemorphbothatPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatPath::min(self : ImagemorphbothatPath) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatPath::max(self : ImagemorphbothatPath) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatPath::to_string(self : ImagemorphbothatPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_cluster_make(size : Int) -> ImagemorphbothatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatCluster::len(self : ImagemorphbothatCluster) -> Int { self.size }

pub fn ImagemorphbothatCluster::get(self : ImagemorphbothatCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatCluster::set(self : ImagemorphbothatCluster, i : Int, v : Double) -> ImagemorphbothatCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCluster::sum(self : ImagemorphbothatCluster) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatCluster::mean(self : ImagemorphbothatCluster) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatCluster::scale(self : ImagemorphbothatCluster, f : Double) -> ImagemorphbothatCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCluster::add(self : ImagemorphbothatCluster, other : ImagemorphbothatCluster) -> ImagemorphbothatCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatCluster::copy(self : ImagemorphbothatCluster) -> ImagemorphbothatCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCluster::fill(self : ImagemorphbothatCluster, v : Double) -> ImagemorphbothatCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCluster::min(self : ImagemorphbothatCluster) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatCluster::max(self : ImagemorphbothatCluster) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatCluster::to_string(self : ImagemorphbothatCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_model_make(size : Int) -> ImagemorphbothatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatModel::len(self : ImagemorphbothatModel) -> Int { self.size }

pub fn ImagemorphbothatModel::get(self : ImagemorphbothatModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatModel::set(self : ImagemorphbothatModel, i : Int, v : Double) -> ImagemorphbothatModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatModel::sum(self : ImagemorphbothatModel) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatModel::mean(self : ImagemorphbothatModel) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatModel::scale(self : ImagemorphbothatModel, f : Double) -> ImagemorphbothatModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatModel::add(self : ImagemorphbothatModel, other : ImagemorphbothatModel) -> ImagemorphbothatModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatModel::copy(self : ImagemorphbothatModel) -> ImagemorphbothatModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatModel::fill(self : ImagemorphbothatModel, v : Double) -> ImagemorphbothatModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatModel::min(self : ImagemorphbothatModel) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatModel::max(self : ImagemorphbothatModel) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatModel::to_string(self : ImagemorphbothatModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_layer_make(size : Int) -> ImagemorphbothatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatLayer::len(self : ImagemorphbothatLayer) -> Int { self.size }

pub fn ImagemorphbothatLayer::get(self : ImagemorphbothatLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatLayer::set(self : ImagemorphbothatLayer, i : Int, v : Double) -> ImagemorphbothatLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatLayer::sum(self : ImagemorphbothatLayer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatLayer::mean(self : ImagemorphbothatLayer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatLayer::scale(self : ImagemorphbothatLayer, f : Double) -> ImagemorphbothatLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatLayer::add(self : ImagemorphbothatLayer, other : ImagemorphbothatLayer) -> ImagemorphbothatLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatLayer::copy(self : ImagemorphbothatLayer) -> ImagemorphbothatLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatLayer::fill(self : ImagemorphbothatLayer, v : Double) -> ImagemorphbothatLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatLayer::min(self : ImagemorphbothatLayer) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatLayer::max(self : ImagemorphbothatLayer) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatLayer::to_string(self : ImagemorphbothatLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_buffer_make(size : Int) -> ImagemorphbothatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatBuffer::len(self : ImagemorphbothatBuffer) -> Int { self.size }

pub fn ImagemorphbothatBuffer::get(self : ImagemorphbothatBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatBuffer::set(self : ImagemorphbothatBuffer, i : Int, v : Double) -> ImagemorphbothatBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatBuffer::sum(self : ImagemorphbothatBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatBuffer::mean(self : ImagemorphbothatBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatBuffer::scale(self : ImagemorphbothatBuffer, f : Double) -> ImagemorphbothatBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatBuffer::add(self : ImagemorphbothatBuffer, other : ImagemorphbothatBuffer) -> ImagemorphbothatBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatBuffer::copy(self : ImagemorphbothatBuffer) -> ImagemorphbothatBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatBuffer::fill(self : ImagemorphbothatBuffer, v : Double) -> ImagemorphbothatBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatBuffer::min(self : ImagemorphbothatBuffer) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatBuffer::max(self : ImagemorphbothatBuffer) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatBuffer::to_string(self : ImagemorphbothatBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_cursor_make(size : Int) -> ImagemorphbothatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatCursor::len(self : ImagemorphbothatCursor) -> Int { self.size }

pub fn ImagemorphbothatCursor::get(self : ImagemorphbothatCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatCursor::set(self : ImagemorphbothatCursor, i : Int, v : Double) -> ImagemorphbothatCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCursor::sum(self : ImagemorphbothatCursor) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatCursor::mean(self : ImagemorphbothatCursor) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatCursor::scale(self : ImagemorphbothatCursor, f : Double) -> ImagemorphbothatCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCursor::add(self : ImagemorphbothatCursor, other : ImagemorphbothatCursor) -> ImagemorphbothatCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatCursor::copy(self : ImagemorphbothatCursor) -> ImagemorphbothatCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCursor::fill(self : ImagemorphbothatCursor, v : Double) -> ImagemorphbothatCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatCursor::min(self : ImagemorphbothatCursor) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatCursor::max(self : ImagemorphbothatCursor) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatCursor::to_string(self : ImagemorphbothatCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_view_make(size : Int) -> ImagemorphbothatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatView::len(self : ImagemorphbothatView) -> Int { self.size }

pub fn ImagemorphbothatView::get(self : ImagemorphbothatView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatView::set(self : ImagemorphbothatView, i : Int, v : Double) -> ImagemorphbothatView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatView::sum(self : ImagemorphbothatView) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatView::mean(self : ImagemorphbothatView) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatView::scale(self : ImagemorphbothatView, f : Double) -> ImagemorphbothatView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatView::add(self : ImagemorphbothatView, other : ImagemorphbothatView) -> ImagemorphbothatView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatView::copy(self : ImagemorphbothatView) -> ImagemorphbothatView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatView::fill(self : ImagemorphbothatView, v : Double) -> ImagemorphbothatView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatView::min(self : ImagemorphbothatView) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatView::max(self : ImagemorphbothatView) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatView::to_string(self : ImagemorphbothatView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_range_make(size : Int) -> ImagemorphbothatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatRange::len(self : ImagemorphbothatRange) -> Int { self.size }

pub fn ImagemorphbothatRange::get(self : ImagemorphbothatRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatRange::set(self : ImagemorphbothatRange, i : Int, v : Double) -> ImagemorphbothatRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatRange::sum(self : ImagemorphbothatRange) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatRange::mean(self : ImagemorphbothatRange) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatRange::scale(self : ImagemorphbothatRange, f : Double) -> ImagemorphbothatRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatRange::add(self : ImagemorphbothatRange, other : ImagemorphbothatRange) -> ImagemorphbothatRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatRange::copy(self : ImagemorphbothatRange) -> ImagemorphbothatRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatRange::fill(self : ImagemorphbothatRange, v : Double) -> ImagemorphbothatRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatRange::min(self : ImagemorphbothatRange) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatRange::max(self : ImagemorphbothatRange) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatRange::to_string(self : ImagemorphbothatRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_slice_make(size : Int) -> ImagemorphbothatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagemorphbothatSlice::len(self : ImagemorphbothatSlice) -> Int { self.size }

pub fn ImagemorphbothatSlice::get(self : ImagemorphbothatSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagemorphbothatSlice::set(self : ImagemorphbothatSlice, i : Int, v : Double) -> ImagemorphbothatSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatSlice::sum(self : ImagemorphbothatSlice) -> Double { @_common.sum(self.data) }

pub fn ImagemorphbothatSlice::mean(self : ImagemorphbothatSlice) -> Double { @_common.mean(self.data) }

pub fn ImagemorphbothatSlice::scale(self : ImagemorphbothatSlice, f : Double) -> ImagemorphbothatSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatSlice::add(self : ImagemorphbothatSlice, other : ImagemorphbothatSlice) -> ImagemorphbothatSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagemorphbothatSlice::copy(self : ImagemorphbothatSlice) -> ImagemorphbothatSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatSlice::fill(self : ImagemorphbothatSlice, v : Double) -> ImagemorphbothatSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagemorphbothatSlice::min(self : ImagemorphbothatSlice) -> Double { @_common.min(self.data) }

pub fn ImagemorphbothatSlice::max(self : ImagemorphbothatSlice) -> Double { @_common.max(self.data) }

pub fn ImagemorphbothatSlice::to_string(self : ImagemorphbothatSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

