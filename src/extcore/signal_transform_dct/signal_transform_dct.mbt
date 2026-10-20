///===
/// extcore/signal_transform_dct

pub(all) struct SignaltransformdctPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dct_make_point(x : Double, y : Double) -> SignaltransformdctPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dct_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdctPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformdctPoint::x(self : SignaltransformdctPoint) -> Double { self.x }

pub fn SignaltransformdctPoint::y(self : SignaltransformdctPoint) -> Double { self.y }

pub fn SignaltransformdctPoint::z(self : SignaltransformdctPoint) -> Double { self.z }

pub fn SignaltransformdctPoint::label(self : SignaltransformdctPoint) -> Int { self.label }

pub fn SignaltransformdctPoint::dist(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformdctPoint::add(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformdctPoint::sub(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformdctPoint::scale(self : SignaltransformdctPoint, s : Double) -> SignaltransformdctPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformdctPoint::dot(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformdctPoint::cross(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformdctPoint::norm(self : SignaltransformdctPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformdctPoint::normalize(self : SignaltransformdctPoint) -> SignaltransformdctPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdctPoint::negate(self : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformdctPoint::mid(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformdctPoint::lerp(self : SignaltransformdctPoint, other : SignaltransformdctPoint, t : Double) -> SignaltransformdctPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformdctPoint::to_string(self : SignaltransformdctPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformdctSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dct_make_series(vals : Array[Double], name : String) -> SignaltransformdctSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformdctSeries::len(self : SignaltransformdctSeries) -> Int { self.vals.length() }

pub fn SignaltransformdctSeries::sum(self : SignaltransformdctSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformdctSeries::mean(self : SignaltransformdctSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformdctSeries::min(self : SignaltransformdctSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformdctSeries::max(self : SignaltransformdctSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformdctSeries::range(self : SignaltransformdctSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformdctSeries::variance(self : SignaltransformdctSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformdctSeries::std(self : SignaltransformdctSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformdctSeries::median(self : SignaltransformdctSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformdctSeries::scale(self : SignaltransformdctSeries, f : Double) -> SignaltransformdctSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformdctSeries::add(self : SignaltransformdctSeries, other : SignaltransformdctSeries) -> SignaltransformdctSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformdctSeries::sub(self : SignaltransformdctSeries, other : SignaltransformdctSeries) -> SignaltransformdctSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformdctSeries::normalize(self : SignaltransformdctSeries) -> SignaltransformdctSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformdctSeries::cumsum(self : SignaltransformdctSeries) -> SignaltransformdctSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformdctSeries::to_string(self : SignaltransformdctSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdctMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dct_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdctMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_transform_dct_matrix_identity(n : Int) -> SignaltransformdctMatrix {
  let m = signal_transform_dct_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformdctMatrix::get(self : SignaltransformdctMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformdctMatrix::transpose(self : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  let result = signal_transform_dct_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformdctMatrix::add(self : SignaltransformdctMatrix, other : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_dct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformdctMatrix::scale(self : SignaltransformdctMatrix, s : Double) -> SignaltransformdctMatrix {
  let result = signal_transform_dct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformdctMatrix::multiply(self : SignaltransformdctMatrix, other : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  if self.cols != other.rows { return signal_transform_dct_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_dct_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignaltransformdctMatrix::trace(self : SignaltransformdctMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformdctMatrix::det(self : SignaltransformdctMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformdctMatrix::norm(self : SignaltransformdctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformdctMatrix::to_string(self : SignaltransformdctMatrix) -> String {
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

pub(all) struct SignaltransformdctVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dct_make_vector(comps : Array[Double]) -> SignaltransformdctVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dct_vector_zero(dim : Int) -> SignaltransformdctVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformdctVector::add(self : SignaltransformdctVector, other : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdctVector::sub(self : SignaltransformdctVector, other : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdctVector::scale(self : SignaltransformdctVector, s : Double) -> SignaltransformdctVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformdctVector::dot(self : SignaltransformdctVector, other : SignaltransformdctVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformdctVector::norm(self : SignaltransformdctVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformdctVector::normalize(self : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdctVector::dist(self : SignaltransformdctVector, other : SignaltransformdctVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformdctVector::to_string(self : SignaltransformdctVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdctFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_frame_make(size : Int) -> SignaltransformdctFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctFrame::len(self : SignaltransformdctFrame) -> Int { self.size }

pub fn SignaltransformdctFrame::get(self : SignaltransformdctFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctFrame::set(self : SignaltransformdctFrame, i : Int, v : Double) -> SignaltransformdctFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctFrame::sum(self : SignaltransformdctFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctFrame::mean(self : SignaltransformdctFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctFrame::scale(self : SignaltransformdctFrame, f : Double) -> SignaltransformdctFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctFrame::add(self : SignaltransformdctFrame, other : SignaltransformdctFrame) -> SignaltransformdctFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctFrame::copy(self : SignaltransformdctFrame) -> SignaltransformdctFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctFrame::fill(self : SignaltransformdctFrame, v : Double) -> SignaltransformdctFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctFrame::min(self : SignaltransformdctFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctFrame::max(self : SignaltransformdctFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctFrame::to_string(self : SignaltransformdctFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_table_make(size : Int) -> SignaltransformdctTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctTable::len(self : SignaltransformdctTable) -> Int { self.size }

pub fn SignaltransformdctTable::get(self : SignaltransformdctTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctTable::set(self : SignaltransformdctTable, i : Int, v : Double) -> SignaltransformdctTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctTable::sum(self : SignaltransformdctTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctTable::mean(self : SignaltransformdctTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctTable::scale(self : SignaltransformdctTable, f : Double) -> SignaltransformdctTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctTable::add(self : SignaltransformdctTable, other : SignaltransformdctTable) -> SignaltransformdctTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctTable::copy(self : SignaltransformdctTable) -> SignaltransformdctTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctTable::fill(self : SignaltransformdctTable, v : Double) -> SignaltransformdctTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctTable::min(self : SignaltransformdctTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctTable::max(self : SignaltransformdctTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctTable::to_string(self : SignaltransformdctTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_graphn_make(size : Int) -> SignaltransformdctGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctGraphN::len(self : SignaltransformdctGraphN) -> Int { self.size }

pub fn SignaltransformdctGraphN::get(self : SignaltransformdctGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctGraphN::set(self : SignaltransformdctGraphN, i : Int, v : Double) -> SignaltransformdctGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctGraphN::sum(self : SignaltransformdctGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctGraphN::mean(self : SignaltransformdctGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctGraphN::scale(self : SignaltransformdctGraphN, f : Double) -> SignaltransformdctGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctGraphN::add(self : SignaltransformdctGraphN, other : SignaltransformdctGraphN) -> SignaltransformdctGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctGraphN::copy(self : SignaltransformdctGraphN) -> SignaltransformdctGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctGraphN::fill(self : SignaltransformdctGraphN, v : Double) -> SignaltransformdctGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctGraphN::min(self : SignaltransformdctGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctGraphN::max(self : SignaltransformdctGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctGraphN::to_string(self : SignaltransformdctGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_node_make(size : Int) -> SignaltransformdctNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctNode::len(self : SignaltransformdctNode) -> Int { self.size }

pub fn SignaltransformdctNode::get(self : SignaltransformdctNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctNode::set(self : SignaltransformdctNode, i : Int, v : Double) -> SignaltransformdctNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctNode::sum(self : SignaltransformdctNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctNode::mean(self : SignaltransformdctNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctNode::scale(self : SignaltransformdctNode, f : Double) -> SignaltransformdctNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctNode::add(self : SignaltransformdctNode, other : SignaltransformdctNode) -> SignaltransformdctNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctNode::copy(self : SignaltransformdctNode) -> SignaltransformdctNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctNode::fill(self : SignaltransformdctNode, v : Double) -> SignaltransformdctNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctNode::min(self : SignaltransformdctNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctNode::max(self : SignaltransformdctNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctNode::to_string(self : SignaltransformdctNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_edge_make(size : Int) -> SignaltransformdctEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctEdge::len(self : SignaltransformdctEdge) -> Int { self.size }

pub fn SignaltransformdctEdge::get(self : SignaltransformdctEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctEdge::set(self : SignaltransformdctEdge, i : Int, v : Double) -> SignaltransformdctEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctEdge::sum(self : SignaltransformdctEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctEdge::mean(self : SignaltransformdctEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctEdge::scale(self : SignaltransformdctEdge, f : Double) -> SignaltransformdctEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctEdge::add(self : SignaltransformdctEdge, other : SignaltransformdctEdge) -> SignaltransformdctEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctEdge::copy(self : SignaltransformdctEdge) -> SignaltransformdctEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctEdge::fill(self : SignaltransformdctEdge, v : Double) -> SignaltransformdctEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctEdge::min(self : SignaltransformdctEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctEdge::max(self : SignaltransformdctEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctEdge::to_string(self : SignaltransformdctEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_path_make(size : Int) -> SignaltransformdctPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctPath::len(self : SignaltransformdctPath) -> Int { self.size }

pub fn SignaltransformdctPath::get(self : SignaltransformdctPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctPath::set(self : SignaltransformdctPath, i : Int, v : Double) -> SignaltransformdctPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctPath::sum(self : SignaltransformdctPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctPath::mean(self : SignaltransformdctPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctPath::scale(self : SignaltransformdctPath, f : Double) -> SignaltransformdctPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctPath::add(self : SignaltransformdctPath, other : SignaltransformdctPath) -> SignaltransformdctPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctPath::copy(self : SignaltransformdctPath) -> SignaltransformdctPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctPath::fill(self : SignaltransformdctPath, v : Double) -> SignaltransformdctPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctPath::min(self : SignaltransformdctPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctPath::max(self : SignaltransformdctPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctPath::to_string(self : SignaltransformdctPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_cluster_make(size : Int) -> SignaltransformdctCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctCluster::len(self : SignaltransformdctCluster) -> Int { self.size }

pub fn SignaltransformdctCluster::get(self : SignaltransformdctCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctCluster::set(self : SignaltransformdctCluster, i : Int, v : Double) -> SignaltransformdctCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCluster::sum(self : SignaltransformdctCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctCluster::mean(self : SignaltransformdctCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctCluster::scale(self : SignaltransformdctCluster, f : Double) -> SignaltransformdctCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCluster::add(self : SignaltransformdctCluster, other : SignaltransformdctCluster) -> SignaltransformdctCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctCluster::copy(self : SignaltransformdctCluster) -> SignaltransformdctCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCluster::fill(self : SignaltransformdctCluster, v : Double) -> SignaltransformdctCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCluster::min(self : SignaltransformdctCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctCluster::max(self : SignaltransformdctCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctCluster::to_string(self : SignaltransformdctCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_model_make(size : Int) -> SignaltransformdctModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctModel::len(self : SignaltransformdctModel) -> Int { self.size }

pub fn SignaltransformdctModel::get(self : SignaltransformdctModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctModel::set(self : SignaltransformdctModel, i : Int, v : Double) -> SignaltransformdctModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctModel::sum(self : SignaltransformdctModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctModel::mean(self : SignaltransformdctModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctModel::scale(self : SignaltransformdctModel, f : Double) -> SignaltransformdctModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctModel::add(self : SignaltransformdctModel, other : SignaltransformdctModel) -> SignaltransformdctModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctModel::copy(self : SignaltransformdctModel) -> SignaltransformdctModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctModel::fill(self : SignaltransformdctModel, v : Double) -> SignaltransformdctModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctModel::min(self : SignaltransformdctModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctModel::max(self : SignaltransformdctModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctModel::to_string(self : SignaltransformdctModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_layer_make(size : Int) -> SignaltransformdctLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctLayer::len(self : SignaltransformdctLayer) -> Int { self.size }

pub fn SignaltransformdctLayer::get(self : SignaltransformdctLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctLayer::set(self : SignaltransformdctLayer, i : Int, v : Double) -> SignaltransformdctLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctLayer::sum(self : SignaltransformdctLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctLayer::mean(self : SignaltransformdctLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctLayer::scale(self : SignaltransformdctLayer, f : Double) -> SignaltransformdctLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctLayer::add(self : SignaltransformdctLayer, other : SignaltransformdctLayer) -> SignaltransformdctLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctLayer::copy(self : SignaltransformdctLayer) -> SignaltransformdctLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctLayer::fill(self : SignaltransformdctLayer, v : Double) -> SignaltransformdctLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctLayer::min(self : SignaltransformdctLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctLayer::max(self : SignaltransformdctLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctLayer::to_string(self : SignaltransformdctLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_buffer_make(size : Int) -> SignaltransformdctBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctBuffer::len(self : SignaltransformdctBuffer) -> Int { self.size }

pub fn SignaltransformdctBuffer::get(self : SignaltransformdctBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctBuffer::set(self : SignaltransformdctBuffer, i : Int, v : Double) -> SignaltransformdctBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctBuffer::sum(self : SignaltransformdctBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctBuffer::mean(self : SignaltransformdctBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctBuffer::scale(self : SignaltransformdctBuffer, f : Double) -> SignaltransformdctBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctBuffer::add(self : SignaltransformdctBuffer, other : SignaltransformdctBuffer) -> SignaltransformdctBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctBuffer::copy(self : SignaltransformdctBuffer) -> SignaltransformdctBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctBuffer::fill(self : SignaltransformdctBuffer, v : Double) -> SignaltransformdctBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctBuffer::min(self : SignaltransformdctBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctBuffer::max(self : SignaltransformdctBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctBuffer::to_string(self : SignaltransformdctBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_cursor_make(size : Int) -> SignaltransformdctCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctCursor::len(self : SignaltransformdctCursor) -> Int { self.size }

pub fn SignaltransformdctCursor::get(self : SignaltransformdctCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctCursor::set(self : SignaltransformdctCursor, i : Int, v : Double) -> SignaltransformdctCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCursor::sum(self : SignaltransformdctCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctCursor::mean(self : SignaltransformdctCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctCursor::scale(self : SignaltransformdctCursor, f : Double) -> SignaltransformdctCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCursor::add(self : SignaltransformdctCursor, other : SignaltransformdctCursor) -> SignaltransformdctCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctCursor::copy(self : SignaltransformdctCursor) -> SignaltransformdctCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCursor::fill(self : SignaltransformdctCursor, v : Double) -> SignaltransformdctCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctCursor::min(self : SignaltransformdctCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctCursor::max(self : SignaltransformdctCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctCursor::to_string(self : SignaltransformdctCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_view_make(size : Int) -> SignaltransformdctView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctView::len(self : SignaltransformdctView) -> Int { self.size }

pub fn SignaltransformdctView::get(self : SignaltransformdctView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctView::set(self : SignaltransformdctView, i : Int, v : Double) -> SignaltransformdctView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctView::sum(self : SignaltransformdctView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctView::mean(self : SignaltransformdctView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctView::scale(self : SignaltransformdctView, f : Double) -> SignaltransformdctView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctView::add(self : SignaltransformdctView, other : SignaltransformdctView) -> SignaltransformdctView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctView::copy(self : SignaltransformdctView) -> SignaltransformdctView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctView::fill(self : SignaltransformdctView, v : Double) -> SignaltransformdctView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctView::min(self : SignaltransformdctView) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctView::max(self : SignaltransformdctView) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctView::to_string(self : SignaltransformdctView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_range_make(size : Int) -> SignaltransformdctRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctRange::len(self : SignaltransformdctRange) -> Int { self.size }

pub fn SignaltransformdctRange::get(self : SignaltransformdctRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctRange::set(self : SignaltransformdctRange, i : Int, v : Double) -> SignaltransformdctRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctRange::sum(self : SignaltransformdctRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctRange::mean(self : SignaltransformdctRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctRange::scale(self : SignaltransformdctRange, f : Double) -> SignaltransformdctRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctRange::add(self : SignaltransformdctRange, other : SignaltransformdctRange) -> SignaltransformdctRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctRange::copy(self : SignaltransformdctRange) -> SignaltransformdctRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctRange::fill(self : SignaltransformdctRange, v : Double) -> SignaltransformdctRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctRange::min(self : SignaltransformdctRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctRange::max(self : SignaltransformdctRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctRange::to_string(self : SignaltransformdctRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_slice_make(size : Int) -> SignaltransformdctSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdctSlice::len(self : SignaltransformdctSlice) -> Int { self.size }

pub fn SignaltransformdctSlice::get(self : SignaltransformdctSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdctSlice::set(self : SignaltransformdctSlice, i : Int, v : Double) -> SignaltransformdctSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdctSlice::sum(self : SignaltransformdctSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdctSlice::mean(self : SignaltransformdctSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdctSlice::scale(self : SignaltransformdctSlice, f : Double) -> SignaltransformdctSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctSlice::add(self : SignaltransformdctSlice, other : SignaltransformdctSlice) -> SignaltransformdctSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdctSlice::copy(self : SignaltransformdctSlice) -> SignaltransformdctSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctSlice::fill(self : SignaltransformdctSlice, v : Double) -> SignaltransformdctSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdctSlice::min(self : SignaltransformdctSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformdctSlice::max(self : SignaltransformdctSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformdctSlice::to_string(self : SignaltransformdctSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

