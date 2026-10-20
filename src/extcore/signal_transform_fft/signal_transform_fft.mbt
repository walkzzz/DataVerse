///===
/// extcore/signal_transform_fft

pub(all) struct SignaltransformfftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_fft_make_point(x : Double, y : Double) -> SignaltransformfftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_fft_make_point3(x : Double, y : Double, z : Double) -> SignaltransformfftPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformfftPoint::x(self : SignaltransformfftPoint) -> Double { self.x }

pub fn SignaltransformfftPoint::y(self : SignaltransformfftPoint) -> Double { self.y }

pub fn SignaltransformfftPoint::z(self : SignaltransformfftPoint) -> Double { self.z }

pub fn SignaltransformfftPoint::label(self : SignaltransformfftPoint) -> Int { self.label }

pub fn SignaltransformfftPoint::dist(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformfftPoint::add(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformfftPoint::sub(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformfftPoint::scale(self : SignaltransformfftPoint, s : Double) -> SignaltransformfftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformfftPoint::dot(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformfftPoint::cross(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformfftPoint::norm(self : SignaltransformfftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformfftPoint::normalize(self : SignaltransformfftPoint) -> SignaltransformfftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformfftPoint::negate(self : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformfftPoint::mid(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformfftPoint::lerp(self : SignaltransformfftPoint, other : SignaltransformfftPoint, t : Double) -> SignaltransformfftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformfftPoint::to_string(self : SignaltransformfftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformfftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_fft_make_series(vals : Array[Double], name : String) -> SignaltransformfftSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformfftSeries::len(self : SignaltransformfftSeries) -> Int { self.vals.length() }

pub fn SignaltransformfftSeries::sum(self : SignaltransformfftSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformfftSeries::mean(self : SignaltransformfftSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformfftSeries::min(self : SignaltransformfftSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformfftSeries::max(self : SignaltransformfftSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformfftSeries::range(self : SignaltransformfftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformfftSeries::variance(self : SignaltransformfftSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformfftSeries::std(self : SignaltransformfftSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformfftSeries::median(self : SignaltransformfftSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformfftSeries::scale(self : SignaltransformfftSeries, f : Double) -> SignaltransformfftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformfftSeries::add(self : SignaltransformfftSeries, other : SignaltransformfftSeries) -> SignaltransformfftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformfftSeries::sub(self : SignaltransformfftSeries, other : SignaltransformfftSeries) -> SignaltransformfftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformfftSeries::normalize(self : SignaltransformfftSeries) -> SignaltransformfftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformfftSeries::cumsum(self : SignaltransformfftSeries) -> SignaltransformfftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformfftSeries::to_string(self : SignaltransformfftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformfftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_fft_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformfftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_fft_matrix_identity(n : Int) -> SignaltransformfftMatrix {
  let m = signal_transform_fft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformfftMatrix::get(self : SignaltransformfftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformfftMatrix::transpose(self : SignaltransformfftMatrix) -> SignaltransformfftMatrix {
  let result = signal_transform_fft_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformfftMatrix::add(self : SignaltransformfftMatrix, other : SignaltransformfftMatrix) -> SignaltransformfftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_fft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformfftMatrix::scale(self : SignaltransformfftMatrix, s : Double) -> SignaltransformfftMatrix {
  let result = signal_transform_fft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformfftMatrix::multiply(self : SignaltransformfftMatrix, other : SignaltransformfftMatrix) -> SignaltransformfftMatrix {
  if self.cols != other.rows { return signal_transform_fft_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_fft_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignaltransformfftMatrix::trace(self : SignaltransformfftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformfftMatrix::det(self : SignaltransformfftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformfftMatrix::norm(self : SignaltransformfftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformfftMatrix::to_string(self : SignaltransformfftMatrix) -> String {
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

pub(all) struct SignaltransformfftVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_fft_make_vector(comps : Array[Double]) -> SignaltransformfftVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_fft_vector_zero(dim : Int) -> SignaltransformfftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformfftVector::add(self : SignaltransformfftVector, other : SignaltransformfftVector) -> SignaltransformfftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformfftVector::sub(self : SignaltransformfftVector, other : SignaltransformfftVector) -> SignaltransformfftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformfftVector::scale(self : SignaltransformfftVector, s : Double) -> SignaltransformfftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformfftVector::dot(self : SignaltransformfftVector, other : SignaltransformfftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformfftVector::norm(self : SignaltransformfftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformfftVector::normalize(self : SignaltransformfftVector) -> SignaltransformfftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformfftVector::dist(self : SignaltransformfftVector, other : SignaltransformfftVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformfftVector::to_string(self : SignaltransformfftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformfftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_frame_make(size : Int) -> SignaltransformfftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftFrame::len(self : SignaltransformfftFrame) -> Int { self.size }

pub fn SignaltransformfftFrame::get(self : SignaltransformfftFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftFrame::set(self : SignaltransformfftFrame, i : Int, v : Double) -> SignaltransformfftFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftFrame::sum(self : SignaltransformfftFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftFrame::mean(self : SignaltransformfftFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftFrame::scale(self : SignaltransformfftFrame, f : Double) -> SignaltransformfftFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftFrame::add(self : SignaltransformfftFrame, other : SignaltransformfftFrame) -> SignaltransformfftFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftFrame::copy(self : SignaltransformfftFrame) -> SignaltransformfftFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftFrame::fill(self : SignaltransformfftFrame, v : Double) -> SignaltransformfftFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftFrame::min(self : SignaltransformfftFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftFrame::max(self : SignaltransformfftFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftFrame::to_string(self : SignaltransformfftFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_table_make(size : Int) -> SignaltransformfftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftTable::len(self : SignaltransformfftTable) -> Int { self.size }

pub fn SignaltransformfftTable::get(self : SignaltransformfftTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftTable::set(self : SignaltransformfftTable, i : Int, v : Double) -> SignaltransformfftTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftTable::sum(self : SignaltransformfftTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftTable::mean(self : SignaltransformfftTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftTable::scale(self : SignaltransformfftTable, f : Double) -> SignaltransformfftTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftTable::add(self : SignaltransformfftTable, other : SignaltransformfftTable) -> SignaltransformfftTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftTable::copy(self : SignaltransformfftTable) -> SignaltransformfftTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftTable::fill(self : SignaltransformfftTable, v : Double) -> SignaltransformfftTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftTable::min(self : SignaltransformfftTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftTable::max(self : SignaltransformfftTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftTable::to_string(self : SignaltransformfftTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_graphn_make(size : Int) -> SignaltransformfftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftGraphN::len(self : SignaltransformfftGraphN) -> Int { self.size }

pub fn SignaltransformfftGraphN::get(self : SignaltransformfftGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftGraphN::set(self : SignaltransformfftGraphN, i : Int, v : Double) -> SignaltransformfftGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftGraphN::sum(self : SignaltransformfftGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftGraphN::mean(self : SignaltransformfftGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftGraphN::scale(self : SignaltransformfftGraphN, f : Double) -> SignaltransformfftGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftGraphN::add(self : SignaltransformfftGraphN, other : SignaltransformfftGraphN) -> SignaltransformfftGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftGraphN::copy(self : SignaltransformfftGraphN) -> SignaltransformfftGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftGraphN::fill(self : SignaltransformfftGraphN, v : Double) -> SignaltransformfftGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftGraphN::min(self : SignaltransformfftGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftGraphN::max(self : SignaltransformfftGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftGraphN::to_string(self : SignaltransformfftGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_node_make(size : Int) -> SignaltransformfftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftNode::len(self : SignaltransformfftNode) -> Int { self.size }

pub fn SignaltransformfftNode::get(self : SignaltransformfftNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftNode::set(self : SignaltransformfftNode, i : Int, v : Double) -> SignaltransformfftNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftNode::sum(self : SignaltransformfftNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftNode::mean(self : SignaltransformfftNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftNode::scale(self : SignaltransformfftNode, f : Double) -> SignaltransformfftNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftNode::add(self : SignaltransformfftNode, other : SignaltransformfftNode) -> SignaltransformfftNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftNode::copy(self : SignaltransformfftNode) -> SignaltransformfftNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftNode::fill(self : SignaltransformfftNode, v : Double) -> SignaltransformfftNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftNode::min(self : SignaltransformfftNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftNode::max(self : SignaltransformfftNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftNode::to_string(self : SignaltransformfftNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_edge_make(size : Int) -> SignaltransformfftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftEdge::len(self : SignaltransformfftEdge) -> Int { self.size }

pub fn SignaltransformfftEdge::get(self : SignaltransformfftEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftEdge::set(self : SignaltransformfftEdge, i : Int, v : Double) -> SignaltransformfftEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftEdge::sum(self : SignaltransformfftEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftEdge::mean(self : SignaltransformfftEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftEdge::scale(self : SignaltransformfftEdge, f : Double) -> SignaltransformfftEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftEdge::add(self : SignaltransformfftEdge, other : SignaltransformfftEdge) -> SignaltransformfftEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftEdge::copy(self : SignaltransformfftEdge) -> SignaltransformfftEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftEdge::fill(self : SignaltransformfftEdge, v : Double) -> SignaltransformfftEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftEdge::min(self : SignaltransformfftEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftEdge::max(self : SignaltransformfftEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftEdge::to_string(self : SignaltransformfftEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_path_make(size : Int) -> SignaltransformfftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftPath::len(self : SignaltransformfftPath) -> Int { self.size }

pub fn SignaltransformfftPath::get(self : SignaltransformfftPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftPath::set(self : SignaltransformfftPath, i : Int, v : Double) -> SignaltransformfftPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftPath::sum(self : SignaltransformfftPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftPath::mean(self : SignaltransformfftPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftPath::scale(self : SignaltransformfftPath, f : Double) -> SignaltransformfftPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftPath::add(self : SignaltransformfftPath, other : SignaltransformfftPath) -> SignaltransformfftPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftPath::copy(self : SignaltransformfftPath) -> SignaltransformfftPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftPath::fill(self : SignaltransformfftPath, v : Double) -> SignaltransformfftPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftPath::min(self : SignaltransformfftPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftPath::max(self : SignaltransformfftPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftPath::to_string(self : SignaltransformfftPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_cluster_make(size : Int) -> SignaltransformfftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftCluster::len(self : SignaltransformfftCluster) -> Int { self.size }

pub fn SignaltransformfftCluster::get(self : SignaltransformfftCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftCluster::set(self : SignaltransformfftCluster, i : Int, v : Double) -> SignaltransformfftCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCluster::sum(self : SignaltransformfftCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftCluster::mean(self : SignaltransformfftCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftCluster::scale(self : SignaltransformfftCluster, f : Double) -> SignaltransformfftCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCluster::add(self : SignaltransformfftCluster, other : SignaltransformfftCluster) -> SignaltransformfftCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftCluster::copy(self : SignaltransformfftCluster) -> SignaltransformfftCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCluster::fill(self : SignaltransformfftCluster, v : Double) -> SignaltransformfftCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCluster::min(self : SignaltransformfftCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftCluster::max(self : SignaltransformfftCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftCluster::to_string(self : SignaltransformfftCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_model_make(size : Int) -> SignaltransformfftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftModel::len(self : SignaltransformfftModel) -> Int { self.size }

pub fn SignaltransformfftModel::get(self : SignaltransformfftModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftModel::set(self : SignaltransformfftModel, i : Int, v : Double) -> SignaltransformfftModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftModel::sum(self : SignaltransformfftModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftModel::mean(self : SignaltransformfftModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftModel::scale(self : SignaltransformfftModel, f : Double) -> SignaltransformfftModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftModel::add(self : SignaltransformfftModel, other : SignaltransformfftModel) -> SignaltransformfftModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftModel::copy(self : SignaltransformfftModel) -> SignaltransformfftModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftModel::fill(self : SignaltransformfftModel, v : Double) -> SignaltransformfftModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftModel::min(self : SignaltransformfftModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftModel::max(self : SignaltransformfftModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftModel::to_string(self : SignaltransformfftModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_layer_make(size : Int) -> SignaltransformfftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftLayer::len(self : SignaltransformfftLayer) -> Int { self.size }

pub fn SignaltransformfftLayer::get(self : SignaltransformfftLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftLayer::set(self : SignaltransformfftLayer, i : Int, v : Double) -> SignaltransformfftLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftLayer::sum(self : SignaltransformfftLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftLayer::mean(self : SignaltransformfftLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftLayer::scale(self : SignaltransformfftLayer, f : Double) -> SignaltransformfftLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftLayer::add(self : SignaltransformfftLayer, other : SignaltransformfftLayer) -> SignaltransformfftLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftLayer::copy(self : SignaltransformfftLayer) -> SignaltransformfftLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftLayer::fill(self : SignaltransformfftLayer, v : Double) -> SignaltransformfftLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftLayer::min(self : SignaltransformfftLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftLayer::max(self : SignaltransformfftLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftLayer::to_string(self : SignaltransformfftLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_buffer_make(size : Int) -> SignaltransformfftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftBuffer::len(self : SignaltransformfftBuffer) -> Int { self.size }

pub fn SignaltransformfftBuffer::get(self : SignaltransformfftBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftBuffer::set(self : SignaltransformfftBuffer, i : Int, v : Double) -> SignaltransformfftBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftBuffer::sum(self : SignaltransformfftBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftBuffer::mean(self : SignaltransformfftBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftBuffer::scale(self : SignaltransformfftBuffer, f : Double) -> SignaltransformfftBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftBuffer::add(self : SignaltransformfftBuffer, other : SignaltransformfftBuffer) -> SignaltransformfftBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftBuffer::copy(self : SignaltransformfftBuffer) -> SignaltransformfftBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftBuffer::fill(self : SignaltransformfftBuffer, v : Double) -> SignaltransformfftBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftBuffer::min(self : SignaltransformfftBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftBuffer::max(self : SignaltransformfftBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftBuffer::to_string(self : SignaltransformfftBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_cursor_make(size : Int) -> SignaltransformfftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftCursor::len(self : SignaltransformfftCursor) -> Int { self.size }

pub fn SignaltransformfftCursor::get(self : SignaltransformfftCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftCursor::set(self : SignaltransformfftCursor, i : Int, v : Double) -> SignaltransformfftCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCursor::sum(self : SignaltransformfftCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftCursor::mean(self : SignaltransformfftCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftCursor::scale(self : SignaltransformfftCursor, f : Double) -> SignaltransformfftCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCursor::add(self : SignaltransformfftCursor, other : SignaltransformfftCursor) -> SignaltransformfftCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftCursor::copy(self : SignaltransformfftCursor) -> SignaltransformfftCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCursor::fill(self : SignaltransformfftCursor, v : Double) -> SignaltransformfftCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftCursor::min(self : SignaltransformfftCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftCursor::max(self : SignaltransformfftCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftCursor::to_string(self : SignaltransformfftCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_view_make(size : Int) -> SignaltransformfftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftView::len(self : SignaltransformfftView) -> Int { self.size }

pub fn SignaltransformfftView::get(self : SignaltransformfftView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftView::set(self : SignaltransformfftView, i : Int, v : Double) -> SignaltransformfftView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftView::sum(self : SignaltransformfftView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftView::mean(self : SignaltransformfftView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftView::scale(self : SignaltransformfftView, f : Double) -> SignaltransformfftView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftView::add(self : SignaltransformfftView, other : SignaltransformfftView) -> SignaltransformfftView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftView::copy(self : SignaltransformfftView) -> SignaltransformfftView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftView::fill(self : SignaltransformfftView, v : Double) -> SignaltransformfftView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftView::min(self : SignaltransformfftView) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftView::max(self : SignaltransformfftView) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftView::to_string(self : SignaltransformfftView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_range_make(size : Int) -> SignaltransformfftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftRange::len(self : SignaltransformfftRange) -> Int { self.size }

pub fn SignaltransformfftRange::get(self : SignaltransformfftRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftRange::set(self : SignaltransformfftRange, i : Int, v : Double) -> SignaltransformfftRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftRange::sum(self : SignaltransformfftRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftRange::mean(self : SignaltransformfftRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftRange::scale(self : SignaltransformfftRange, f : Double) -> SignaltransformfftRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftRange::add(self : SignaltransformfftRange, other : SignaltransformfftRange) -> SignaltransformfftRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftRange::copy(self : SignaltransformfftRange) -> SignaltransformfftRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftRange::fill(self : SignaltransformfftRange, v : Double) -> SignaltransformfftRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftRange::min(self : SignaltransformfftRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftRange::max(self : SignaltransformfftRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftRange::to_string(self : SignaltransformfftRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_slice_make(size : Int) -> SignaltransformfftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformfftSlice::len(self : SignaltransformfftSlice) -> Int { self.size }

pub fn SignaltransformfftSlice::get(self : SignaltransformfftSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformfftSlice::set(self : SignaltransformfftSlice, i : Int, v : Double) -> SignaltransformfftSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformfftSlice::sum(self : SignaltransformfftSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformfftSlice::mean(self : SignaltransformfftSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformfftSlice::scale(self : SignaltransformfftSlice, f : Double) -> SignaltransformfftSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftSlice::add(self : SignaltransformfftSlice, other : SignaltransformfftSlice) -> SignaltransformfftSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformfftSlice::copy(self : SignaltransformfftSlice) -> SignaltransformfftSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftSlice::fill(self : SignaltransformfftSlice, v : Double) -> SignaltransformfftSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformfftSlice::min(self : SignaltransformfftSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformfftSlice::max(self : SignaltransformfftSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformfftSlice::to_string(self : SignaltransformfftSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

