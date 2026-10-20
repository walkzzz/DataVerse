///===
/// extcore/signal_transform_gabor

pub(all) struct SignaltransformgaborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_gabor_make_point(x : Double, y : Double) -> SignaltransformgaborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_gabor_make_point3(x : Double, y : Double, z : Double) -> SignaltransformgaborPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformgaborPoint::x(self : SignaltransformgaborPoint) -> Double { self.x }

pub fn SignaltransformgaborPoint::y(self : SignaltransformgaborPoint) -> Double { self.y }

pub fn SignaltransformgaborPoint::z(self : SignaltransformgaborPoint) -> Double { self.z }

pub fn SignaltransformgaborPoint::label(self : SignaltransformgaborPoint) -> Int { self.label }

pub fn SignaltransformgaborPoint::dist(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformgaborPoint::add(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformgaborPoint::sub(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformgaborPoint::scale(self : SignaltransformgaborPoint, s : Double) -> SignaltransformgaborPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformgaborPoint::dot(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformgaborPoint::cross(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformgaborPoint::norm(self : SignaltransformgaborPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformgaborPoint::normalize(self : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformgaborPoint::negate(self : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformgaborPoint::mid(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformgaborPoint::lerp(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint, t : Double) -> SignaltransformgaborPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformgaborPoint::to_string(self : SignaltransformgaborPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformgaborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_gabor_make_series(vals : Array[Double], name : String) -> SignaltransformgaborSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformgaborSeries::len(self : SignaltransformgaborSeries) -> Int { self.vals.length() }

pub fn SignaltransformgaborSeries::sum(self : SignaltransformgaborSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformgaborSeries::mean(self : SignaltransformgaborSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformgaborSeries::min(self : SignaltransformgaborSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformgaborSeries::max(self : SignaltransformgaborSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformgaborSeries::range(self : SignaltransformgaborSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformgaborSeries::variance(self : SignaltransformgaborSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformgaborSeries::std(self : SignaltransformgaborSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformgaborSeries::median(self : SignaltransformgaborSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformgaborSeries::scale(self : SignaltransformgaborSeries, f : Double) -> SignaltransformgaborSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformgaborSeries::add(self : SignaltransformgaborSeries, other : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformgaborSeries::sub(self : SignaltransformgaborSeries, other : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformgaborSeries::normalize(self : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformgaborSeries::cumsum(self : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformgaborSeries::to_string(self : SignaltransformgaborSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformgaborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_gabor_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformgaborMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_gabor_matrix_identity(n : Int) -> SignaltransformgaborMatrix {
  let m = signal_transform_gabor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformgaborMatrix::get(self : SignaltransformgaborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformgaborMatrix::transpose(self : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  let result = signal_transform_gabor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformgaborMatrix::add(self : SignaltransformgaborMatrix, other : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformgaborMatrix::scale(self : SignaltransformgaborMatrix, s : Double) -> SignaltransformgaborMatrix {
  let result = signal_transform_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformgaborMatrix::multiply(self : SignaltransformgaborMatrix, other : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  if self.cols != other.rows { return signal_transform_gabor_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_gabor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformgaborMatrix::trace(self : SignaltransformgaborMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformgaborMatrix::det(self : SignaltransformgaborMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformgaborMatrix::norm(self : SignaltransformgaborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformgaborMatrix::to_string(self : SignaltransformgaborMatrix) -> String {
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

pub(all) struct SignaltransformgaborVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_gabor_make_vector(comps : Array[Double]) -> SignaltransformgaborVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_gabor_vector_zero(dim : Int) -> SignaltransformgaborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformgaborVector::add(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformgaborVector::sub(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformgaborVector::scale(self : SignaltransformgaborVector, s : Double) -> SignaltransformgaborVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformgaborVector::dot(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformgaborVector::norm(self : SignaltransformgaborVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformgaborVector::normalize(self : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformgaborVector::dist(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformgaborVector::to_string(self : SignaltransformgaborVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformgaborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_frame_make(size : Int) -> SignaltransformgaborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborFrame::len(self : SignaltransformgaborFrame) -> Int { self.size }

pub fn SignaltransformgaborFrame::get(self : SignaltransformgaborFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborFrame::set(self : SignaltransformgaborFrame, i : Int, v : Double) -> SignaltransformgaborFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborFrame::sum(self : SignaltransformgaborFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborFrame::mean(self : SignaltransformgaborFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborFrame::scale(self : SignaltransformgaborFrame, f : Double) -> SignaltransformgaborFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborFrame::add(self : SignaltransformgaborFrame, other : SignaltransformgaborFrame) -> SignaltransformgaborFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborFrame::copy(self : SignaltransformgaborFrame) -> SignaltransformgaborFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborFrame::fill(self : SignaltransformgaborFrame, v : Double) -> SignaltransformgaborFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborFrame::min(self : SignaltransformgaborFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborFrame::max(self : SignaltransformgaborFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborFrame::to_string(self : SignaltransformgaborFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_table_make(size : Int) -> SignaltransformgaborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborTable::len(self : SignaltransformgaborTable) -> Int { self.size }

pub fn SignaltransformgaborTable::get(self : SignaltransformgaborTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborTable::set(self : SignaltransformgaborTable, i : Int, v : Double) -> SignaltransformgaborTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborTable::sum(self : SignaltransformgaborTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborTable::mean(self : SignaltransformgaborTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborTable::scale(self : SignaltransformgaborTable, f : Double) -> SignaltransformgaborTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborTable::add(self : SignaltransformgaborTable, other : SignaltransformgaborTable) -> SignaltransformgaborTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborTable::copy(self : SignaltransformgaborTable) -> SignaltransformgaborTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborTable::fill(self : SignaltransformgaborTable, v : Double) -> SignaltransformgaborTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborTable::min(self : SignaltransformgaborTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborTable::max(self : SignaltransformgaborTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborTable::to_string(self : SignaltransformgaborTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_graphn_make(size : Int) -> SignaltransformgaborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborGraphN::len(self : SignaltransformgaborGraphN) -> Int { self.size }

pub fn SignaltransformgaborGraphN::get(self : SignaltransformgaborGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborGraphN::set(self : SignaltransformgaborGraphN, i : Int, v : Double) -> SignaltransformgaborGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborGraphN::sum(self : SignaltransformgaborGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborGraphN::mean(self : SignaltransformgaborGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborGraphN::scale(self : SignaltransformgaborGraphN, f : Double) -> SignaltransformgaborGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborGraphN::add(self : SignaltransformgaborGraphN, other : SignaltransformgaborGraphN) -> SignaltransformgaborGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborGraphN::copy(self : SignaltransformgaborGraphN) -> SignaltransformgaborGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborGraphN::fill(self : SignaltransformgaborGraphN, v : Double) -> SignaltransformgaborGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborGraphN::min(self : SignaltransformgaborGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborGraphN::max(self : SignaltransformgaborGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborGraphN::to_string(self : SignaltransformgaborGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_node_make(size : Int) -> SignaltransformgaborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborNode::len(self : SignaltransformgaborNode) -> Int { self.size }

pub fn SignaltransformgaborNode::get(self : SignaltransformgaborNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborNode::set(self : SignaltransformgaborNode, i : Int, v : Double) -> SignaltransformgaborNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborNode::sum(self : SignaltransformgaborNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborNode::mean(self : SignaltransformgaborNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborNode::scale(self : SignaltransformgaborNode, f : Double) -> SignaltransformgaborNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborNode::add(self : SignaltransformgaborNode, other : SignaltransformgaborNode) -> SignaltransformgaborNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborNode::copy(self : SignaltransformgaborNode) -> SignaltransformgaborNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborNode::fill(self : SignaltransformgaborNode, v : Double) -> SignaltransformgaborNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborNode::min(self : SignaltransformgaborNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborNode::max(self : SignaltransformgaborNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborNode::to_string(self : SignaltransformgaborNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_edge_make(size : Int) -> SignaltransformgaborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborEdge::len(self : SignaltransformgaborEdge) -> Int { self.size }

pub fn SignaltransformgaborEdge::get(self : SignaltransformgaborEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborEdge::set(self : SignaltransformgaborEdge, i : Int, v : Double) -> SignaltransformgaborEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborEdge::sum(self : SignaltransformgaborEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborEdge::mean(self : SignaltransformgaborEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborEdge::scale(self : SignaltransformgaborEdge, f : Double) -> SignaltransformgaborEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborEdge::add(self : SignaltransformgaborEdge, other : SignaltransformgaborEdge) -> SignaltransformgaborEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborEdge::copy(self : SignaltransformgaborEdge) -> SignaltransformgaborEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborEdge::fill(self : SignaltransformgaborEdge, v : Double) -> SignaltransformgaborEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborEdge::min(self : SignaltransformgaborEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborEdge::max(self : SignaltransformgaborEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborEdge::to_string(self : SignaltransformgaborEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_path_make(size : Int) -> SignaltransformgaborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborPath::len(self : SignaltransformgaborPath) -> Int { self.size }

pub fn SignaltransformgaborPath::get(self : SignaltransformgaborPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborPath::set(self : SignaltransformgaborPath, i : Int, v : Double) -> SignaltransformgaborPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborPath::sum(self : SignaltransformgaborPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborPath::mean(self : SignaltransformgaborPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborPath::scale(self : SignaltransformgaborPath, f : Double) -> SignaltransformgaborPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborPath::add(self : SignaltransformgaborPath, other : SignaltransformgaborPath) -> SignaltransformgaborPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborPath::copy(self : SignaltransformgaborPath) -> SignaltransformgaborPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborPath::fill(self : SignaltransformgaborPath, v : Double) -> SignaltransformgaborPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborPath::min(self : SignaltransformgaborPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborPath::max(self : SignaltransformgaborPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborPath::to_string(self : SignaltransformgaborPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_cluster_make(size : Int) -> SignaltransformgaborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborCluster::len(self : SignaltransformgaborCluster) -> Int { self.size }

pub fn SignaltransformgaborCluster::get(self : SignaltransformgaborCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborCluster::set(self : SignaltransformgaborCluster, i : Int, v : Double) -> SignaltransformgaborCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCluster::sum(self : SignaltransformgaborCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborCluster::mean(self : SignaltransformgaborCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborCluster::scale(self : SignaltransformgaborCluster, f : Double) -> SignaltransformgaborCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCluster::add(self : SignaltransformgaborCluster, other : SignaltransformgaborCluster) -> SignaltransformgaborCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborCluster::copy(self : SignaltransformgaborCluster) -> SignaltransformgaborCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCluster::fill(self : SignaltransformgaborCluster, v : Double) -> SignaltransformgaborCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCluster::min(self : SignaltransformgaborCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborCluster::max(self : SignaltransformgaborCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborCluster::to_string(self : SignaltransformgaborCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_model_make(size : Int) -> SignaltransformgaborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborModel::len(self : SignaltransformgaborModel) -> Int { self.size }

pub fn SignaltransformgaborModel::get(self : SignaltransformgaborModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborModel::set(self : SignaltransformgaborModel, i : Int, v : Double) -> SignaltransformgaborModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborModel::sum(self : SignaltransformgaborModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborModel::mean(self : SignaltransformgaborModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborModel::scale(self : SignaltransformgaborModel, f : Double) -> SignaltransformgaborModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborModel::add(self : SignaltransformgaborModel, other : SignaltransformgaborModel) -> SignaltransformgaborModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborModel::copy(self : SignaltransformgaborModel) -> SignaltransformgaborModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborModel::fill(self : SignaltransformgaborModel, v : Double) -> SignaltransformgaborModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborModel::min(self : SignaltransformgaborModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborModel::max(self : SignaltransformgaborModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborModel::to_string(self : SignaltransformgaborModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_layer_make(size : Int) -> SignaltransformgaborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborLayer::len(self : SignaltransformgaborLayer) -> Int { self.size }

pub fn SignaltransformgaborLayer::get(self : SignaltransformgaborLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborLayer::set(self : SignaltransformgaborLayer, i : Int, v : Double) -> SignaltransformgaborLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborLayer::sum(self : SignaltransformgaborLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborLayer::mean(self : SignaltransformgaborLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborLayer::scale(self : SignaltransformgaborLayer, f : Double) -> SignaltransformgaborLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborLayer::add(self : SignaltransformgaborLayer, other : SignaltransformgaborLayer) -> SignaltransformgaborLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborLayer::copy(self : SignaltransformgaborLayer) -> SignaltransformgaborLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborLayer::fill(self : SignaltransformgaborLayer, v : Double) -> SignaltransformgaborLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborLayer::min(self : SignaltransformgaborLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborLayer::max(self : SignaltransformgaborLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborLayer::to_string(self : SignaltransformgaborLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_buffer_make(size : Int) -> SignaltransformgaborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborBuffer::len(self : SignaltransformgaborBuffer) -> Int { self.size }

pub fn SignaltransformgaborBuffer::get(self : SignaltransformgaborBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborBuffer::set(self : SignaltransformgaborBuffer, i : Int, v : Double) -> SignaltransformgaborBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborBuffer::sum(self : SignaltransformgaborBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborBuffer::mean(self : SignaltransformgaborBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborBuffer::scale(self : SignaltransformgaborBuffer, f : Double) -> SignaltransformgaborBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborBuffer::add(self : SignaltransformgaborBuffer, other : SignaltransformgaborBuffer) -> SignaltransformgaborBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborBuffer::copy(self : SignaltransformgaborBuffer) -> SignaltransformgaborBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborBuffer::fill(self : SignaltransformgaborBuffer, v : Double) -> SignaltransformgaborBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborBuffer::min(self : SignaltransformgaborBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborBuffer::max(self : SignaltransformgaborBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborBuffer::to_string(self : SignaltransformgaborBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_cursor_make(size : Int) -> SignaltransformgaborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborCursor::len(self : SignaltransformgaborCursor) -> Int { self.size }

pub fn SignaltransformgaborCursor::get(self : SignaltransformgaborCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborCursor::set(self : SignaltransformgaborCursor, i : Int, v : Double) -> SignaltransformgaborCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCursor::sum(self : SignaltransformgaborCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborCursor::mean(self : SignaltransformgaborCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborCursor::scale(self : SignaltransformgaborCursor, f : Double) -> SignaltransformgaborCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCursor::add(self : SignaltransformgaborCursor, other : SignaltransformgaborCursor) -> SignaltransformgaborCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborCursor::copy(self : SignaltransformgaborCursor) -> SignaltransformgaborCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCursor::fill(self : SignaltransformgaborCursor, v : Double) -> SignaltransformgaborCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborCursor::min(self : SignaltransformgaborCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborCursor::max(self : SignaltransformgaborCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborCursor::to_string(self : SignaltransformgaborCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_view_make(size : Int) -> SignaltransformgaborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborView::len(self : SignaltransformgaborView) -> Int { self.size }

pub fn SignaltransformgaborView::get(self : SignaltransformgaborView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborView::set(self : SignaltransformgaborView, i : Int, v : Double) -> SignaltransformgaborView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborView::sum(self : SignaltransformgaborView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborView::mean(self : SignaltransformgaborView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborView::scale(self : SignaltransformgaborView, f : Double) -> SignaltransformgaborView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborView::add(self : SignaltransformgaborView, other : SignaltransformgaborView) -> SignaltransformgaborView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborView::copy(self : SignaltransformgaborView) -> SignaltransformgaborView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborView::fill(self : SignaltransformgaborView, v : Double) -> SignaltransformgaborView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborView::min(self : SignaltransformgaborView) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborView::max(self : SignaltransformgaborView) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborView::to_string(self : SignaltransformgaborView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_range_make(size : Int) -> SignaltransformgaborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborRange::len(self : SignaltransformgaborRange) -> Int { self.size }

pub fn SignaltransformgaborRange::get(self : SignaltransformgaborRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborRange::set(self : SignaltransformgaborRange, i : Int, v : Double) -> SignaltransformgaborRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborRange::sum(self : SignaltransformgaborRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborRange::mean(self : SignaltransformgaborRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborRange::scale(self : SignaltransformgaborRange, f : Double) -> SignaltransformgaborRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborRange::add(self : SignaltransformgaborRange, other : SignaltransformgaborRange) -> SignaltransformgaborRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborRange::copy(self : SignaltransformgaborRange) -> SignaltransformgaborRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborRange::fill(self : SignaltransformgaborRange, v : Double) -> SignaltransformgaborRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborRange::min(self : SignaltransformgaborRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborRange::max(self : SignaltransformgaborRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborRange::to_string(self : SignaltransformgaborRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_slice_make(size : Int) -> SignaltransformgaborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformgaborSlice::len(self : SignaltransformgaborSlice) -> Int { self.size }

pub fn SignaltransformgaborSlice::get(self : SignaltransformgaborSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformgaborSlice::set(self : SignaltransformgaborSlice, i : Int, v : Double) -> SignaltransformgaborSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborSlice::sum(self : SignaltransformgaborSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformgaborSlice::mean(self : SignaltransformgaborSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformgaborSlice::scale(self : SignaltransformgaborSlice, f : Double) -> SignaltransformgaborSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborSlice::add(self : SignaltransformgaborSlice, other : SignaltransformgaborSlice) -> SignaltransformgaborSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformgaborSlice::copy(self : SignaltransformgaborSlice) -> SignaltransformgaborSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborSlice::fill(self : SignaltransformgaborSlice, v : Double) -> SignaltransformgaborSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformgaborSlice::min(self : SignaltransformgaborSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformgaborSlice::max(self : SignaltransformgaborSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformgaborSlice::to_string(self : SignaltransformgaborSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

