///===
/// extcore/image_transform_translate

pub(all) struct ImagetransformtranslatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_translate_make_point(x : Double, y : Double) -> ImagetransformtranslatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_translate_make_point3(x : Double, y : Double, z : Double) -> ImagetransformtranslatePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformtranslatePoint::x(self : ImagetransformtranslatePoint) -> Double { self.x }

pub fn ImagetransformtranslatePoint::y(self : ImagetransformtranslatePoint) -> Double { self.y }

pub fn ImagetransformtranslatePoint::z(self : ImagetransformtranslatePoint) -> Double { self.z }

pub fn ImagetransformtranslatePoint::label(self : ImagetransformtranslatePoint) -> Int { self.label }

pub fn ImagetransformtranslatePoint::dist(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformtranslatePoint::add(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformtranslatePoint::sub(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformtranslatePoint::scale(self : ImagetransformtranslatePoint, s : Double) -> ImagetransformtranslatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformtranslatePoint::dot(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformtranslatePoint::cross(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformtranslatePoint::norm(self : ImagetransformtranslatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformtranslatePoint::normalize(self : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformtranslatePoint::negate(self : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformtranslatePoint::mid(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformtranslatePoint::lerp(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint, t : Double) -> ImagetransformtranslatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformtranslatePoint::to_string(self : ImagetransformtranslatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformtranslateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_translate_make_series(vals : Array[Double], name : String) -> ImagetransformtranslateSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformtranslateSeries::len(self : ImagetransformtranslateSeries) -> Int { self.vals.length() }

pub fn ImagetransformtranslateSeries::sum(self : ImagetransformtranslateSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformtranslateSeries::mean(self : ImagetransformtranslateSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformtranslateSeries::min(self : ImagetransformtranslateSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformtranslateSeries::max(self : ImagetransformtranslateSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformtranslateSeries::range(self : ImagetransformtranslateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformtranslateSeries::variance(self : ImagetransformtranslateSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformtranslateSeries::std(self : ImagetransformtranslateSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformtranslateSeries::median(self : ImagetransformtranslateSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformtranslateSeries::scale(self : ImagetransformtranslateSeries, f : Double) -> ImagetransformtranslateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformtranslateSeries::add(self : ImagetransformtranslateSeries, other : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformtranslateSeries::sub(self : ImagetransformtranslateSeries, other : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformtranslateSeries::normalize(self : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformtranslateSeries::cumsum(self : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformtranslateSeries::to_string(self : ImagetransformtranslateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtranslateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_translate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformtranslateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_translate_matrix_identity(n : Int) -> ImagetransformtranslateMatrix {
  let m = image_transform_translate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformtranslateMatrix::get(self : ImagetransformtranslateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformtranslateMatrix::transpose(self : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  let result = image_transform_translate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformtranslateMatrix::add(self : ImagetransformtranslateMatrix, other : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_translate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformtranslateMatrix::scale(self : ImagetransformtranslateMatrix, s : Double) -> ImagetransformtranslateMatrix {
  let result = image_transform_translate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformtranslateMatrix::multiply(self : ImagetransformtranslateMatrix, other : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  if self.cols != other.rows { return image_transform_translate_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_translate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformtranslateMatrix::trace(self : ImagetransformtranslateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformtranslateMatrix::det(self : ImagetransformtranslateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformtranslateMatrix::norm(self : ImagetransformtranslateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformtranslateMatrix::to_string(self : ImagetransformtranslateMatrix) -> String {
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

pub(all) struct ImagetransformtranslateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_translate_make_vector(comps : Array[Double]) -> ImagetransformtranslateVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_translate_vector_zero(dim : Int) -> ImagetransformtranslateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformtranslateVector::add(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformtranslateVector::sub(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformtranslateVector::scale(self : ImagetransformtranslateVector, s : Double) -> ImagetransformtranslateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformtranslateVector::dot(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformtranslateVector::norm(self : ImagetransformtranslateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformtranslateVector::normalize(self : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformtranslateVector::dist(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformtranslateVector::to_string(self : ImagetransformtranslateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtranslateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_frame_make(size : Int) -> ImagetransformtranslateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateFrame::len(self : ImagetransformtranslateFrame) -> Int { self.size }

pub fn ImagetransformtranslateFrame::get(self : ImagetransformtranslateFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateFrame::set(self : ImagetransformtranslateFrame, i : Int, v : Double) -> ImagetransformtranslateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateFrame::sum(self : ImagetransformtranslateFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateFrame::mean(self : ImagetransformtranslateFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateFrame::scale(self : ImagetransformtranslateFrame, f : Double) -> ImagetransformtranslateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateFrame::add(self : ImagetransformtranslateFrame, other : ImagetransformtranslateFrame) -> ImagetransformtranslateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateFrame::copy(self : ImagetransformtranslateFrame) -> ImagetransformtranslateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateFrame::fill(self : ImagetransformtranslateFrame, v : Double) -> ImagetransformtranslateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateFrame::min(self : ImagetransformtranslateFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateFrame::max(self : ImagetransformtranslateFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateFrame::to_string(self : ImagetransformtranslateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_table_make(size : Int) -> ImagetransformtranslateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateTable::len(self : ImagetransformtranslateTable) -> Int { self.size }

pub fn ImagetransformtranslateTable::get(self : ImagetransformtranslateTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateTable::set(self : ImagetransformtranslateTable, i : Int, v : Double) -> ImagetransformtranslateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateTable::sum(self : ImagetransformtranslateTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateTable::mean(self : ImagetransformtranslateTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateTable::scale(self : ImagetransformtranslateTable, f : Double) -> ImagetransformtranslateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateTable::add(self : ImagetransformtranslateTable, other : ImagetransformtranslateTable) -> ImagetransformtranslateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateTable::copy(self : ImagetransformtranslateTable) -> ImagetransformtranslateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateTable::fill(self : ImagetransformtranslateTable, v : Double) -> ImagetransformtranslateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateTable::min(self : ImagetransformtranslateTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateTable::max(self : ImagetransformtranslateTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateTable::to_string(self : ImagetransformtranslateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_graphn_make(size : Int) -> ImagetransformtranslateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateGraphN::len(self : ImagetransformtranslateGraphN) -> Int { self.size }

pub fn ImagetransformtranslateGraphN::get(self : ImagetransformtranslateGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateGraphN::set(self : ImagetransformtranslateGraphN, i : Int, v : Double) -> ImagetransformtranslateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateGraphN::sum(self : ImagetransformtranslateGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateGraphN::mean(self : ImagetransformtranslateGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateGraphN::scale(self : ImagetransformtranslateGraphN, f : Double) -> ImagetransformtranslateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateGraphN::add(self : ImagetransformtranslateGraphN, other : ImagetransformtranslateGraphN) -> ImagetransformtranslateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateGraphN::copy(self : ImagetransformtranslateGraphN) -> ImagetransformtranslateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateGraphN::fill(self : ImagetransformtranslateGraphN, v : Double) -> ImagetransformtranslateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateGraphN::min(self : ImagetransformtranslateGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateGraphN::max(self : ImagetransformtranslateGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateGraphN::to_string(self : ImagetransformtranslateGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_node_make(size : Int) -> ImagetransformtranslateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateNode::len(self : ImagetransformtranslateNode) -> Int { self.size }

pub fn ImagetransformtranslateNode::get(self : ImagetransformtranslateNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateNode::set(self : ImagetransformtranslateNode, i : Int, v : Double) -> ImagetransformtranslateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateNode::sum(self : ImagetransformtranslateNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateNode::mean(self : ImagetransformtranslateNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateNode::scale(self : ImagetransformtranslateNode, f : Double) -> ImagetransformtranslateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateNode::add(self : ImagetransformtranslateNode, other : ImagetransformtranslateNode) -> ImagetransformtranslateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateNode::copy(self : ImagetransformtranslateNode) -> ImagetransformtranslateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateNode::fill(self : ImagetransformtranslateNode, v : Double) -> ImagetransformtranslateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateNode::min(self : ImagetransformtranslateNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateNode::max(self : ImagetransformtranslateNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateNode::to_string(self : ImagetransformtranslateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_edge_make(size : Int) -> ImagetransformtranslateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateEdge::len(self : ImagetransformtranslateEdge) -> Int { self.size }

pub fn ImagetransformtranslateEdge::get(self : ImagetransformtranslateEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateEdge::set(self : ImagetransformtranslateEdge, i : Int, v : Double) -> ImagetransformtranslateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateEdge::sum(self : ImagetransformtranslateEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateEdge::mean(self : ImagetransformtranslateEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateEdge::scale(self : ImagetransformtranslateEdge, f : Double) -> ImagetransformtranslateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateEdge::add(self : ImagetransformtranslateEdge, other : ImagetransformtranslateEdge) -> ImagetransformtranslateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateEdge::copy(self : ImagetransformtranslateEdge) -> ImagetransformtranslateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateEdge::fill(self : ImagetransformtranslateEdge, v : Double) -> ImagetransformtranslateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateEdge::min(self : ImagetransformtranslateEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateEdge::max(self : ImagetransformtranslateEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateEdge::to_string(self : ImagetransformtranslateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_path_make(size : Int) -> ImagetransformtranslatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslatePath::len(self : ImagetransformtranslatePath) -> Int { self.size }

pub fn ImagetransformtranslatePath::get(self : ImagetransformtranslatePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslatePath::set(self : ImagetransformtranslatePath, i : Int, v : Double) -> ImagetransformtranslatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslatePath::sum(self : ImagetransformtranslatePath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslatePath::mean(self : ImagetransformtranslatePath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslatePath::scale(self : ImagetransformtranslatePath, f : Double) -> ImagetransformtranslatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslatePath::add(self : ImagetransformtranslatePath, other : ImagetransformtranslatePath) -> ImagetransformtranslatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslatePath::copy(self : ImagetransformtranslatePath) -> ImagetransformtranslatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslatePath::fill(self : ImagetransformtranslatePath, v : Double) -> ImagetransformtranslatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslatePath::min(self : ImagetransformtranslatePath) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslatePath::max(self : ImagetransformtranslatePath) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslatePath::to_string(self : ImagetransformtranslatePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_cluster_make(size : Int) -> ImagetransformtranslateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateCluster::len(self : ImagetransformtranslateCluster) -> Int { self.size }

pub fn ImagetransformtranslateCluster::get(self : ImagetransformtranslateCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateCluster::set(self : ImagetransformtranslateCluster, i : Int, v : Double) -> ImagetransformtranslateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCluster::sum(self : ImagetransformtranslateCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateCluster::mean(self : ImagetransformtranslateCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateCluster::scale(self : ImagetransformtranslateCluster, f : Double) -> ImagetransformtranslateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCluster::add(self : ImagetransformtranslateCluster, other : ImagetransformtranslateCluster) -> ImagetransformtranslateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateCluster::copy(self : ImagetransformtranslateCluster) -> ImagetransformtranslateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCluster::fill(self : ImagetransformtranslateCluster, v : Double) -> ImagetransformtranslateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCluster::min(self : ImagetransformtranslateCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateCluster::max(self : ImagetransformtranslateCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateCluster::to_string(self : ImagetransformtranslateCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_model_make(size : Int) -> ImagetransformtranslateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateModel::len(self : ImagetransformtranslateModel) -> Int { self.size }

pub fn ImagetransformtranslateModel::get(self : ImagetransformtranslateModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateModel::set(self : ImagetransformtranslateModel, i : Int, v : Double) -> ImagetransformtranslateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateModel::sum(self : ImagetransformtranslateModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateModel::mean(self : ImagetransformtranslateModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateModel::scale(self : ImagetransformtranslateModel, f : Double) -> ImagetransformtranslateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateModel::add(self : ImagetransformtranslateModel, other : ImagetransformtranslateModel) -> ImagetransformtranslateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateModel::copy(self : ImagetransformtranslateModel) -> ImagetransformtranslateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateModel::fill(self : ImagetransformtranslateModel, v : Double) -> ImagetransformtranslateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateModel::min(self : ImagetransformtranslateModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateModel::max(self : ImagetransformtranslateModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateModel::to_string(self : ImagetransformtranslateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_layer_make(size : Int) -> ImagetransformtranslateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateLayer::len(self : ImagetransformtranslateLayer) -> Int { self.size }

pub fn ImagetransformtranslateLayer::get(self : ImagetransformtranslateLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateLayer::set(self : ImagetransformtranslateLayer, i : Int, v : Double) -> ImagetransformtranslateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateLayer::sum(self : ImagetransformtranslateLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateLayer::mean(self : ImagetransformtranslateLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateLayer::scale(self : ImagetransformtranslateLayer, f : Double) -> ImagetransformtranslateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateLayer::add(self : ImagetransformtranslateLayer, other : ImagetransformtranslateLayer) -> ImagetransformtranslateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateLayer::copy(self : ImagetransformtranslateLayer) -> ImagetransformtranslateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateLayer::fill(self : ImagetransformtranslateLayer, v : Double) -> ImagetransformtranslateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateLayer::min(self : ImagetransformtranslateLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateLayer::max(self : ImagetransformtranslateLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateLayer::to_string(self : ImagetransformtranslateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_buffer_make(size : Int) -> ImagetransformtranslateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateBuffer::len(self : ImagetransformtranslateBuffer) -> Int { self.size }

pub fn ImagetransformtranslateBuffer::get(self : ImagetransformtranslateBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateBuffer::set(self : ImagetransformtranslateBuffer, i : Int, v : Double) -> ImagetransformtranslateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateBuffer::sum(self : ImagetransformtranslateBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateBuffer::mean(self : ImagetransformtranslateBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateBuffer::scale(self : ImagetransformtranslateBuffer, f : Double) -> ImagetransformtranslateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateBuffer::add(self : ImagetransformtranslateBuffer, other : ImagetransformtranslateBuffer) -> ImagetransformtranslateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateBuffer::copy(self : ImagetransformtranslateBuffer) -> ImagetransformtranslateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateBuffer::fill(self : ImagetransformtranslateBuffer, v : Double) -> ImagetransformtranslateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateBuffer::min(self : ImagetransformtranslateBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateBuffer::max(self : ImagetransformtranslateBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateBuffer::to_string(self : ImagetransformtranslateBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_cursor_make(size : Int) -> ImagetransformtranslateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateCursor::len(self : ImagetransformtranslateCursor) -> Int { self.size }

pub fn ImagetransformtranslateCursor::get(self : ImagetransformtranslateCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateCursor::set(self : ImagetransformtranslateCursor, i : Int, v : Double) -> ImagetransformtranslateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCursor::sum(self : ImagetransformtranslateCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateCursor::mean(self : ImagetransformtranslateCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateCursor::scale(self : ImagetransformtranslateCursor, f : Double) -> ImagetransformtranslateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCursor::add(self : ImagetransformtranslateCursor, other : ImagetransformtranslateCursor) -> ImagetransformtranslateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateCursor::copy(self : ImagetransformtranslateCursor) -> ImagetransformtranslateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCursor::fill(self : ImagetransformtranslateCursor, v : Double) -> ImagetransformtranslateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateCursor::min(self : ImagetransformtranslateCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateCursor::max(self : ImagetransformtranslateCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateCursor::to_string(self : ImagetransformtranslateCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_view_make(size : Int) -> ImagetransformtranslateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateView::len(self : ImagetransformtranslateView) -> Int { self.size }

pub fn ImagetransformtranslateView::get(self : ImagetransformtranslateView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateView::set(self : ImagetransformtranslateView, i : Int, v : Double) -> ImagetransformtranslateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateView::sum(self : ImagetransformtranslateView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateView::mean(self : ImagetransformtranslateView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateView::scale(self : ImagetransformtranslateView, f : Double) -> ImagetransformtranslateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateView::add(self : ImagetransformtranslateView, other : ImagetransformtranslateView) -> ImagetransformtranslateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateView::copy(self : ImagetransformtranslateView) -> ImagetransformtranslateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateView::fill(self : ImagetransformtranslateView, v : Double) -> ImagetransformtranslateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateView::min(self : ImagetransformtranslateView) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateView::max(self : ImagetransformtranslateView) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateView::to_string(self : ImagetransformtranslateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_range_make(size : Int) -> ImagetransformtranslateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateRange::len(self : ImagetransformtranslateRange) -> Int { self.size }

pub fn ImagetransformtranslateRange::get(self : ImagetransformtranslateRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateRange::set(self : ImagetransformtranslateRange, i : Int, v : Double) -> ImagetransformtranslateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateRange::sum(self : ImagetransformtranslateRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateRange::mean(self : ImagetransformtranslateRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateRange::scale(self : ImagetransformtranslateRange, f : Double) -> ImagetransformtranslateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateRange::add(self : ImagetransformtranslateRange, other : ImagetransformtranslateRange) -> ImagetransformtranslateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateRange::copy(self : ImagetransformtranslateRange) -> ImagetransformtranslateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateRange::fill(self : ImagetransformtranslateRange, v : Double) -> ImagetransformtranslateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateRange::min(self : ImagetransformtranslateRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateRange::max(self : ImagetransformtranslateRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateRange::to_string(self : ImagetransformtranslateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_slice_make(size : Int) -> ImagetransformtranslateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformtranslateSlice::len(self : ImagetransformtranslateSlice) -> Int { self.size }

pub fn ImagetransformtranslateSlice::get(self : ImagetransformtranslateSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformtranslateSlice::set(self : ImagetransformtranslateSlice, i : Int, v : Double) -> ImagetransformtranslateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateSlice::sum(self : ImagetransformtranslateSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformtranslateSlice::mean(self : ImagetransformtranslateSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformtranslateSlice::scale(self : ImagetransformtranslateSlice, f : Double) -> ImagetransformtranslateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateSlice::add(self : ImagetransformtranslateSlice, other : ImagetransformtranslateSlice) -> ImagetransformtranslateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformtranslateSlice::copy(self : ImagetransformtranslateSlice) -> ImagetransformtranslateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateSlice::fill(self : ImagetransformtranslateSlice, v : Double) -> ImagetransformtranslateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformtranslateSlice::min(self : ImagetransformtranslateSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformtranslateSlice::max(self : ImagetransformtranslateSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformtranslateSlice::to_string(self : ImagetransformtranslateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

