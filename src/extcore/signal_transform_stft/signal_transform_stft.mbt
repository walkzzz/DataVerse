///===
/// extcore/signal_transform_stft

pub(all) struct SignaltransformstftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_stft_make_point(x : Double, y : Double) -> SignaltransformstftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_stft_make_point3(x : Double, y : Double, z : Double) -> SignaltransformstftPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformstftPoint::x(self : SignaltransformstftPoint) -> Double { self.x }

pub fn SignaltransformstftPoint::y(self : SignaltransformstftPoint) -> Double { self.y }

pub fn SignaltransformstftPoint::z(self : SignaltransformstftPoint) -> Double { self.z }

pub fn SignaltransformstftPoint::label(self : SignaltransformstftPoint) -> Int { self.label }

pub fn SignaltransformstftPoint::dist(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformstftPoint::add(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformstftPoint::sub(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformstftPoint::scale(self : SignaltransformstftPoint, s : Double) -> SignaltransformstftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformstftPoint::dot(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformstftPoint::cross(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformstftPoint::norm(self : SignaltransformstftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformstftPoint::normalize(self : SignaltransformstftPoint) -> SignaltransformstftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformstftPoint::negate(self : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformstftPoint::mid(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformstftPoint::lerp(self : SignaltransformstftPoint, other : SignaltransformstftPoint, t : Double) -> SignaltransformstftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformstftPoint::to_string(self : SignaltransformstftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformstftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_stft_make_series(vals : Array[Double], name : String) -> SignaltransformstftSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformstftSeries::len(self : SignaltransformstftSeries) -> Int { self.vals.length() }

pub fn SignaltransformstftSeries::sum(self : SignaltransformstftSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformstftSeries::mean(self : SignaltransformstftSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformstftSeries::min(self : SignaltransformstftSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformstftSeries::max(self : SignaltransformstftSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformstftSeries::range(self : SignaltransformstftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformstftSeries::variance(self : SignaltransformstftSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformstftSeries::std(self : SignaltransformstftSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformstftSeries::median(self : SignaltransformstftSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformstftSeries::scale(self : SignaltransformstftSeries, f : Double) -> SignaltransformstftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformstftSeries::add(self : SignaltransformstftSeries, other : SignaltransformstftSeries) -> SignaltransformstftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformstftSeries::sub(self : SignaltransformstftSeries, other : SignaltransformstftSeries) -> SignaltransformstftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformstftSeries::normalize(self : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformstftSeries::cumsum(self : SignaltransformstftSeries) -> SignaltransformstftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformstftSeries::to_string(self : SignaltransformstftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformstftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_stft_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformstftMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_transform_stft_matrix_identity(n : Int) -> SignaltransformstftMatrix {
  let m = signal_transform_stft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformstftMatrix::get(self : SignaltransformstftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformstftMatrix::transpose(self : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformstftMatrix::add(self : SignaltransformstftMatrix, other : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_stft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformstftMatrix::scale(self : SignaltransformstftMatrix, s : Double) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformstftMatrix::multiply(self : SignaltransformstftMatrix, other : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if self.cols != other.rows { return signal_transform_stft_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_stft_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignaltransformstftMatrix::trace(self : SignaltransformstftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformstftMatrix::det(self : SignaltransformstftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformstftMatrix::norm(self : SignaltransformstftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformstftMatrix::to_string(self : SignaltransformstftMatrix) -> String {
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

pub(all) struct SignaltransformstftVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_stft_make_vector(comps : Array[Double]) -> SignaltransformstftVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_stft_vector_zero(dim : Int) -> SignaltransformstftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformstftVector::add(self : SignaltransformstftVector, other : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformstftVector::sub(self : SignaltransformstftVector, other : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformstftVector::scale(self : SignaltransformstftVector, s : Double) -> SignaltransformstftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformstftVector::dot(self : SignaltransformstftVector, other : SignaltransformstftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformstftVector::norm(self : SignaltransformstftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformstftVector::normalize(self : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformstftVector::dist(self : SignaltransformstftVector, other : SignaltransformstftVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformstftVector::to_string(self : SignaltransformstftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformstftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_frame_make(size : Int) -> SignaltransformstftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftFrame::len(self : SignaltransformstftFrame) -> Int { self.size }

pub fn SignaltransformstftFrame::get(self : SignaltransformstftFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftFrame::set(self : SignaltransformstftFrame, i : Int, v : Double) -> SignaltransformstftFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftFrame::sum(self : SignaltransformstftFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftFrame::mean(self : SignaltransformstftFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftFrame::scale(self : SignaltransformstftFrame, f : Double) -> SignaltransformstftFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftFrame::add(self : SignaltransformstftFrame, other : SignaltransformstftFrame) -> SignaltransformstftFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftFrame::copy(self : SignaltransformstftFrame) -> SignaltransformstftFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftFrame::fill(self : SignaltransformstftFrame, v : Double) -> SignaltransformstftFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftFrame::min(self : SignaltransformstftFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftFrame::max(self : SignaltransformstftFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftFrame::to_string(self : SignaltransformstftFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_table_make(size : Int) -> SignaltransformstftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftTable::len(self : SignaltransformstftTable) -> Int { self.size }

pub fn SignaltransformstftTable::get(self : SignaltransformstftTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftTable::set(self : SignaltransformstftTable, i : Int, v : Double) -> SignaltransformstftTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftTable::sum(self : SignaltransformstftTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftTable::mean(self : SignaltransformstftTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftTable::scale(self : SignaltransformstftTable, f : Double) -> SignaltransformstftTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftTable::add(self : SignaltransformstftTable, other : SignaltransformstftTable) -> SignaltransformstftTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftTable::copy(self : SignaltransformstftTable) -> SignaltransformstftTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftTable::fill(self : SignaltransformstftTable, v : Double) -> SignaltransformstftTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftTable::min(self : SignaltransformstftTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftTable::max(self : SignaltransformstftTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftTable::to_string(self : SignaltransformstftTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_graphn_make(size : Int) -> SignaltransformstftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftGraphN::len(self : SignaltransformstftGraphN) -> Int { self.size }

pub fn SignaltransformstftGraphN::get(self : SignaltransformstftGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftGraphN::set(self : SignaltransformstftGraphN, i : Int, v : Double) -> SignaltransformstftGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftGraphN::sum(self : SignaltransformstftGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftGraphN::mean(self : SignaltransformstftGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftGraphN::scale(self : SignaltransformstftGraphN, f : Double) -> SignaltransformstftGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftGraphN::add(self : SignaltransformstftGraphN, other : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftGraphN::copy(self : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftGraphN::fill(self : SignaltransformstftGraphN, v : Double) -> SignaltransformstftGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftGraphN::min(self : SignaltransformstftGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftGraphN::max(self : SignaltransformstftGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftGraphN::to_string(self : SignaltransformstftGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_node_make(size : Int) -> SignaltransformstftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftNode::len(self : SignaltransformstftNode) -> Int { self.size }

pub fn SignaltransformstftNode::get(self : SignaltransformstftNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftNode::set(self : SignaltransformstftNode, i : Int, v : Double) -> SignaltransformstftNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftNode::sum(self : SignaltransformstftNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftNode::mean(self : SignaltransformstftNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftNode::scale(self : SignaltransformstftNode, f : Double) -> SignaltransformstftNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftNode::add(self : SignaltransformstftNode, other : SignaltransformstftNode) -> SignaltransformstftNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftNode::copy(self : SignaltransformstftNode) -> SignaltransformstftNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftNode::fill(self : SignaltransformstftNode, v : Double) -> SignaltransformstftNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftNode::min(self : SignaltransformstftNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftNode::max(self : SignaltransformstftNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftNode::to_string(self : SignaltransformstftNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_edge_make(size : Int) -> SignaltransformstftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftEdge::len(self : SignaltransformstftEdge) -> Int { self.size }

pub fn SignaltransformstftEdge::get(self : SignaltransformstftEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftEdge::set(self : SignaltransformstftEdge, i : Int, v : Double) -> SignaltransformstftEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftEdge::sum(self : SignaltransformstftEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftEdge::mean(self : SignaltransformstftEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftEdge::scale(self : SignaltransformstftEdge, f : Double) -> SignaltransformstftEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftEdge::add(self : SignaltransformstftEdge, other : SignaltransformstftEdge) -> SignaltransformstftEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftEdge::copy(self : SignaltransformstftEdge) -> SignaltransformstftEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftEdge::fill(self : SignaltransformstftEdge, v : Double) -> SignaltransformstftEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftEdge::min(self : SignaltransformstftEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftEdge::max(self : SignaltransformstftEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftEdge::to_string(self : SignaltransformstftEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_path_make(size : Int) -> SignaltransformstftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftPath::len(self : SignaltransformstftPath) -> Int { self.size }

pub fn SignaltransformstftPath::get(self : SignaltransformstftPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftPath::set(self : SignaltransformstftPath, i : Int, v : Double) -> SignaltransformstftPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftPath::sum(self : SignaltransformstftPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftPath::mean(self : SignaltransformstftPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftPath::scale(self : SignaltransformstftPath, f : Double) -> SignaltransformstftPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftPath::add(self : SignaltransformstftPath, other : SignaltransformstftPath) -> SignaltransformstftPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftPath::copy(self : SignaltransformstftPath) -> SignaltransformstftPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftPath::fill(self : SignaltransformstftPath, v : Double) -> SignaltransformstftPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftPath::min(self : SignaltransformstftPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftPath::max(self : SignaltransformstftPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftPath::to_string(self : SignaltransformstftPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cluster_make(size : Int) -> SignaltransformstftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftCluster::len(self : SignaltransformstftCluster) -> Int { self.size }

pub fn SignaltransformstftCluster::get(self : SignaltransformstftCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftCluster::set(self : SignaltransformstftCluster, i : Int, v : Double) -> SignaltransformstftCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCluster::sum(self : SignaltransformstftCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftCluster::mean(self : SignaltransformstftCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftCluster::scale(self : SignaltransformstftCluster, f : Double) -> SignaltransformstftCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCluster::add(self : SignaltransformstftCluster, other : SignaltransformstftCluster) -> SignaltransformstftCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftCluster::copy(self : SignaltransformstftCluster) -> SignaltransformstftCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCluster::fill(self : SignaltransformstftCluster, v : Double) -> SignaltransformstftCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCluster::min(self : SignaltransformstftCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftCluster::max(self : SignaltransformstftCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftCluster::to_string(self : SignaltransformstftCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_model_make(size : Int) -> SignaltransformstftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftModel::len(self : SignaltransformstftModel) -> Int { self.size }

pub fn SignaltransformstftModel::get(self : SignaltransformstftModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftModel::set(self : SignaltransformstftModel, i : Int, v : Double) -> SignaltransformstftModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftModel::sum(self : SignaltransformstftModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftModel::mean(self : SignaltransformstftModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftModel::scale(self : SignaltransformstftModel, f : Double) -> SignaltransformstftModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftModel::add(self : SignaltransformstftModel, other : SignaltransformstftModel) -> SignaltransformstftModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftModel::copy(self : SignaltransformstftModel) -> SignaltransformstftModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftModel::fill(self : SignaltransformstftModel, v : Double) -> SignaltransformstftModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftModel::min(self : SignaltransformstftModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftModel::max(self : SignaltransformstftModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftModel::to_string(self : SignaltransformstftModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_layer_make(size : Int) -> SignaltransformstftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftLayer::len(self : SignaltransformstftLayer) -> Int { self.size }

pub fn SignaltransformstftLayer::get(self : SignaltransformstftLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftLayer::set(self : SignaltransformstftLayer, i : Int, v : Double) -> SignaltransformstftLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftLayer::sum(self : SignaltransformstftLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftLayer::mean(self : SignaltransformstftLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftLayer::scale(self : SignaltransformstftLayer, f : Double) -> SignaltransformstftLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftLayer::add(self : SignaltransformstftLayer, other : SignaltransformstftLayer) -> SignaltransformstftLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftLayer::copy(self : SignaltransformstftLayer) -> SignaltransformstftLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftLayer::fill(self : SignaltransformstftLayer, v : Double) -> SignaltransformstftLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftLayer::min(self : SignaltransformstftLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftLayer::max(self : SignaltransformstftLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftLayer::to_string(self : SignaltransformstftLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_buffer_make(size : Int) -> SignaltransformstftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftBuffer::len(self : SignaltransformstftBuffer) -> Int { self.size }

pub fn SignaltransformstftBuffer::get(self : SignaltransformstftBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftBuffer::set(self : SignaltransformstftBuffer, i : Int, v : Double) -> SignaltransformstftBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftBuffer::sum(self : SignaltransformstftBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftBuffer::mean(self : SignaltransformstftBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftBuffer::scale(self : SignaltransformstftBuffer, f : Double) -> SignaltransformstftBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftBuffer::add(self : SignaltransformstftBuffer, other : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftBuffer::copy(self : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftBuffer::fill(self : SignaltransformstftBuffer, v : Double) -> SignaltransformstftBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftBuffer::min(self : SignaltransformstftBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftBuffer::max(self : SignaltransformstftBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftBuffer::to_string(self : SignaltransformstftBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cursor_make(size : Int) -> SignaltransformstftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftCursor::len(self : SignaltransformstftCursor) -> Int { self.size }

pub fn SignaltransformstftCursor::get(self : SignaltransformstftCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftCursor::set(self : SignaltransformstftCursor, i : Int, v : Double) -> SignaltransformstftCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCursor::sum(self : SignaltransformstftCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftCursor::mean(self : SignaltransformstftCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftCursor::scale(self : SignaltransformstftCursor, f : Double) -> SignaltransformstftCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCursor::add(self : SignaltransformstftCursor, other : SignaltransformstftCursor) -> SignaltransformstftCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftCursor::copy(self : SignaltransformstftCursor) -> SignaltransformstftCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCursor::fill(self : SignaltransformstftCursor, v : Double) -> SignaltransformstftCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftCursor::min(self : SignaltransformstftCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftCursor::max(self : SignaltransformstftCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftCursor::to_string(self : SignaltransformstftCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_view_make(size : Int) -> SignaltransformstftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftView::len(self : SignaltransformstftView) -> Int { self.size }

pub fn SignaltransformstftView::get(self : SignaltransformstftView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftView::set(self : SignaltransformstftView, i : Int, v : Double) -> SignaltransformstftView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftView::sum(self : SignaltransformstftView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftView::mean(self : SignaltransformstftView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftView::scale(self : SignaltransformstftView, f : Double) -> SignaltransformstftView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftView::add(self : SignaltransformstftView, other : SignaltransformstftView) -> SignaltransformstftView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftView::copy(self : SignaltransformstftView) -> SignaltransformstftView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftView::fill(self : SignaltransformstftView, v : Double) -> SignaltransformstftView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftView::min(self : SignaltransformstftView) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftView::max(self : SignaltransformstftView) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftView::to_string(self : SignaltransformstftView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_range_make(size : Int) -> SignaltransformstftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftRange::len(self : SignaltransformstftRange) -> Int { self.size }

pub fn SignaltransformstftRange::get(self : SignaltransformstftRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftRange::set(self : SignaltransformstftRange, i : Int, v : Double) -> SignaltransformstftRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftRange::sum(self : SignaltransformstftRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftRange::mean(self : SignaltransformstftRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftRange::scale(self : SignaltransformstftRange, f : Double) -> SignaltransformstftRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftRange::add(self : SignaltransformstftRange, other : SignaltransformstftRange) -> SignaltransformstftRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftRange::copy(self : SignaltransformstftRange) -> SignaltransformstftRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftRange::fill(self : SignaltransformstftRange, v : Double) -> SignaltransformstftRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftRange::min(self : SignaltransformstftRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftRange::max(self : SignaltransformstftRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftRange::to_string(self : SignaltransformstftRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_slice_make(size : Int) -> SignaltransformstftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformstftSlice::len(self : SignaltransformstftSlice) -> Int { self.size }

pub fn SignaltransformstftSlice::get(self : SignaltransformstftSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformstftSlice::set(self : SignaltransformstftSlice, i : Int, v : Double) -> SignaltransformstftSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformstftSlice::sum(self : SignaltransformstftSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformstftSlice::mean(self : SignaltransformstftSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformstftSlice::scale(self : SignaltransformstftSlice, f : Double) -> SignaltransformstftSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftSlice::add(self : SignaltransformstftSlice, other : SignaltransformstftSlice) -> SignaltransformstftSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformstftSlice::copy(self : SignaltransformstftSlice) -> SignaltransformstftSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftSlice::fill(self : SignaltransformstftSlice, v : Double) -> SignaltransformstftSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformstftSlice::min(self : SignaltransformstftSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformstftSlice::max(self : SignaltransformstftSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformstftSlice::to_string(self : SignaltransformstftSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

