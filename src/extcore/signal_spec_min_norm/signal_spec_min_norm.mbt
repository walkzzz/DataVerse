///===
/// extcore/signal_spec_min_norm

pub(all) struct SignalspecminnormPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_min_norm_make_point(x : Double, y : Double) -> SignalspecminnormPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_min_norm_make_point3(x : Double, y : Double, z : Double) -> SignalspecminnormPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecminnormPoint::x(self : SignalspecminnormPoint) -> Double { self.x }

pub fn SignalspecminnormPoint::y(self : SignalspecminnormPoint) -> Double { self.y }

pub fn SignalspecminnormPoint::z(self : SignalspecminnormPoint) -> Double { self.z }

pub fn SignalspecminnormPoint::label(self : SignalspecminnormPoint) -> Int { self.label }

pub fn SignalspecminnormPoint::dist(self : SignalspecminnormPoint, other : SignalspecminnormPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecminnormPoint::add(self : SignalspecminnormPoint, other : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecminnormPoint::sub(self : SignalspecminnormPoint, other : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecminnormPoint::scale(self : SignalspecminnormPoint, s : Double) -> SignalspecminnormPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecminnormPoint::dot(self : SignalspecminnormPoint, other : SignalspecminnormPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecminnormPoint::cross(self : SignalspecminnormPoint, other : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecminnormPoint::norm(self : SignalspecminnormPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecminnormPoint::normalize(self : SignalspecminnormPoint) -> SignalspecminnormPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecminnormPoint::negate(self : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecminnormPoint::mid(self : SignalspecminnormPoint, other : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecminnormPoint::lerp(self : SignalspecminnormPoint, other : SignalspecminnormPoint, t : Double) -> SignalspecminnormPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecminnormPoint::to_string(self : SignalspecminnormPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecminnormSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_min_norm_make_series(vals : Array[Double], name : String) -> SignalspecminnormSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecminnormSeries::len(self : SignalspecminnormSeries) -> Int { self.vals.length() }

pub fn SignalspecminnormSeries::sum(self : SignalspecminnormSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecminnormSeries::mean(self : SignalspecminnormSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecminnormSeries::min(self : SignalspecminnormSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecminnormSeries::max(self : SignalspecminnormSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecminnormSeries::range(self : SignalspecminnormSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecminnormSeries::variance(self : SignalspecminnormSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecminnormSeries::std(self : SignalspecminnormSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecminnormSeries::median(self : SignalspecminnormSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecminnormSeries::scale(self : SignalspecminnormSeries, f : Double) -> SignalspecminnormSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecminnormSeries::add(self : SignalspecminnormSeries, other : SignalspecminnormSeries) -> SignalspecminnormSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecminnormSeries::sub(self : SignalspecminnormSeries, other : SignalspecminnormSeries) -> SignalspecminnormSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecminnormSeries::normalize(self : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecminnormSeries::cumsum(self : SignalspecminnormSeries) -> SignalspecminnormSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecminnormSeries::to_string(self : SignalspecminnormSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecminnormMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_min_norm_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecminnormMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_min_norm_matrix_identity(n : Int) -> SignalspecminnormMatrix {
  let m = signal_spec_min_norm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecminnormMatrix::get(self : SignalspecminnormMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecminnormMatrix::transpose(self : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  let result = signal_spec_min_norm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecminnormMatrix::add(self : SignalspecminnormMatrix, other : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_min_norm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecminnormMatrix::scale(self : SignalspecminnormMatrix, s : Double) -> SignalspecminnormMatrix {
  let result = signal_spec_min_norm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecminnormMatrix::multiply(self : SignalspecminnormMatrix, other : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  if self.cols != other.rows { return signal_spec_min_norm_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_min_norm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecminnormMatrix::trace(self : SignalspecminnormMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecminnormMatrix::det(self : SignalspecminnormMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecminnormMatrix::norm(self : SignalspecminnormMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecminnormMatrix::to_string(self : SignalspecminnormMatrix) -> String {
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

pub(all) struct SignalspecminnormVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_min_norm_make_vector(comps : Array[Double]) -> SignalspecminnormVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_min_norm_vector_zero(dim : Int) -> SignalspecminnormVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecminnormVector::add(self : SignalspecminnormVector, other : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecminnormVector::sub(self : SignalspecminnormVector, other : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecminnormVector::scale(self : SignalspecminnormVector, s : Double) -> SignalspecminnormVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecminnormVector::dot(self : SignalspecminnormVector, other : SignalspecminnormVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecminnormVector::norm(self : SignalspecminnormVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecminnormVector::normalize(self : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecminnormVector::dist(self : SignalspecminnormVector, other : SignalspecminnormVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecminnormVector::to_string(self : SignalspecminnormVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecminnormFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_frame_make(size : Int) -> SignalspecminnormFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormFrame::len(self : SignalspecminnormFrame) -> Int { self.size }

pub fn SignalspecminnormFrame::get(self : SignalspecminnormFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormFrame::set(self : SignalspecminnormFrame, i : Int, v : Double) -> SignalspecminnormFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormFrame::sum(self : SignalspecminnormFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormFrame::mean(self : SignalspecminnormFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormFrame::scale(self : SignalspecminnormFrame, f : Double) -> SignalspecminnormFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormFrame::add(self : SignalspecminnormFrame, other : SignalspecminnormFrame) -> SignalspecminnormFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormFrame::copy(self : SignalspecminnormFrame) -> SignalspecminnormFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormFrame::fill(self : SignalspecminnormFrame, v : Double) -> SignalspecminnormFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormFrame::min(self : SignalspecminnormFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormFrame::max(self : SignalspecminnormFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormFrame::to_string(self : SignalspecminnormFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_table_make(size : Int) -> SignalspecminnormTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormTable::len(self : SignalspecminnormTable) -> Int { self.size }

pub fn SignalspecminnormTable::get(self : SignalspecminnormTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormTable::set(self : SignalspecminnormTable, i : Int, v : Double) -> SignalspecminnormTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormTable::sum(self : SignalspecminnormTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormTable::mean(self : SignalspecminnormTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormTable::scale(self : SignalspecminnormTable, f : Double) -> SignalspecminnormTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormTable::add(self : SignalspecminnormTable, other : SignalspecminnormTable) -> SignalspecminnormTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormTable::copy(self : SignalspecminnormTable) -> SignalspecminnormTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormTable::fill(self : SignalspecminnormTable, v : Double) -> SignalspecminnormTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormTable::min(self : SignalspecminnormTable) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormTable::max(self : SignalspecminnormTable) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormTable::to_string(self : SignalspecminnormTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_graphn_make(size : Int) -> SignalspecminnormGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormGraphN::len(self : SignalspecminnormGraphN) -> Int { self.size }

pub fn SignalspecminnormGraphN::get(self : SignalspecminnormGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormGraphN::set(self : SignalspecminnormGraphN, i : Int, v : Double) -> SignalspecminnormGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormGraphN::sum(self : SignalspecminnormGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormGraphN::mean(self : SignalspecminnormGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormGraphN::scale(self : SignalspecminnormGraphN, f : Double) -> SignalspecminnormGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormGraphN::add(self : SignalspecminnormGraphN, other : SignalspecminnormGraphN) -> SignalspecminnormGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormGraphN::copy(self : SignalspecminnormGraphN) -> SignalspecminnormGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormGraphN::fill(self : SignalspecminnormGraphN, v : Double) -> SignalspecminnormGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormGraphN::min(self : SignalspecminnormGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormGraphN::max(self : SignalspecminnormGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormGraphN::to_string(self : SignalspecminnormGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_node_make(size : Int) -> SignalspecminnormNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormNode::len(self : SignalspecminnormNode) -> Int { self.size }

pub fn SignalspecminnormNode::get(self : SignalspecminnormNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormNode::set(self : SignalspecminnormNode, i : Int, v : Double) -> SignalspecminnormNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormNode::sum(self : SignalspecminnormNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormNode::mean(self : SignalspecminnormNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormNode::scale(self : SignalspecminnormNode, f : Double) -> SignalspecminnormNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormNode::add(self : SignalspecminnormNode, other : SignalspecminnormNode) -> SignalspecminnormNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormNode::copy(self : SignalspecminnormNode) -> SignalspecminnormNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormNode::fill(self : SignalspecminnormNode, v : Double) -> SignalspecminnormNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormNode::min(self : SignalspecminnormNode) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormNode::max(self : SignalspecminnormNode) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormNode::to_string(self : SignalspecminnormNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_edge_make(size : Int) -> SignalspecminnormEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormEdge::len(self : SignalspecminnormEdge) -> Int { self.size }

pub fn SignalspecminnormEdge::get(self : SignalspecminnormEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormEdge::set(self : SignalspecminnormEdge, i : Int, v : Double) -> SignalspecminnormEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormEdge::sum(self : SignalspecminnormEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormEdge::mean(self : SignalspecminnormEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormEdge::scale(self : SignalspecminnormEdge, f : Double) -> SignalspecminnormEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormEdge::add(self : SignalspecminnormEdge, other : SignalspecminnormEdge) -> SignalspecminnormEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormEdge::copy(self : SignalspecminnormEdge) -> SignalspecminnormEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormEdge::fill(self : SignalspecminnormEdge, v : Double) -> SignalspecminnormEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormEdge::min(self : SignalspecminnormEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormEdge::max(self : SignalspecminnormEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormEdge::to_string(self : SignalspecminnormEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_path_make(size : Int) -> SignalspecminnormPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormPath::len(self : SignalspecminnormPath) -> Int { self.size }

pub fn SignalspecminnormPath::get(self : SignalspecminnormPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormPath::set(self : SignalspecminnormPath, i : Int, v : Double) -> SignalspecminnormPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormPath::sum(self : SignalspecminnormPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormPath::mean(self : SignalspecminnormPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormPath::scale(self : SignalspecminnormPath, f : Double) -> SignalspecminnormPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormPath::add(self : SignalspecminnormPath, other : SignalspecminnormPath) -> SignalspecminnormPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormPath::copy(self : SignalspecminnormPath) -> SignalspecminnormPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormPath::fill(self : SignalspecminnormPath, v : Double) -> SignalspecminnormPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormPath::min(self : SignalspecminnormPath) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormPath::max(self : SignalspecminnormPath) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormPath::to_string(self : SignalspecminnormPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_cluster_make(size : Int) -> SignalspecminnormCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormCluster::len(self : SignalspecminnormCluster) -> Int { self.size }

pub fn SignalspecminnormCluster::get(self : SignalspecminnormCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormCluster::set(self : SignalspecminnormCluster, i : Int, v : Double) -> SignalspecminnormCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCluster::sum(self : SignalspecminnormCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormCluster::mean(self : SignalspecminnormCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormCluster::scale(self : SignalspecminnormCluster, f : Double) -> SignalspecminnormCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCluster::add(self : SignalspecminnormCluster, other : SignalspecminnormCluster) -> SignalspecminnormCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormCluster::copy(self : SignalspecminnormCluster) -> SignalspecminnormCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCluster::fill(self : SignalspecminnormCluster, v : Double) -> SignalspecminnormCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCluster::min(self : SignalspecminnormCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormCluster::max(self : SignalspecminnormCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormCluster::to_string(self : SignalspecminnormCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_model_make(size : Int) -> SignalspecminnormModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormModel::len(self : SignalspecminnormModel) -> Int { self.size }

pub fn SignalspecminnormModel::get(self : SignalspecminnormModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormModel::set(self : SignalspecminnormModel, i : Int, v : Double) -> SignalspecminnormModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormModel::sum(self : SignalspecminnormModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormModel::mean(self : SignalspecminnormModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormModel::scale(self : SignalspecminnormModel, f : Double) -> SignalspecminnormModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormModel::add(self : SignalspecminnormModel, other : SignalspecminnormModel) -> SignalspecminnormModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormModel::copy(self : SignalspecminnormModel) -> SignalspecminnormModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormModel::fill(self : SignalspecminnormModel, v : Double) -> SignalspecminnormModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormModel::min(self : SignalspecminnormModel) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormModel::max(self : SignalspecminnormModel) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormModel::to_string(self : SignalspecminnormModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_layer_make(size : Int) -> SignalspecminnormLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormLayer::len(self : SignalspecminnormLayer) -> Int { self.size }

pub fn SignalspecminnormLayer::get(self : SignalspecminnormLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormLayer::set(self : SignalspecminnormLayer, i : Int, v : Double) -> SignalspecminnormLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormLayer::sum(self : SignalspecminnormLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormLayer::mean(self : SignalspecminnormLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormLayer::scale(self : SignalspecminnormLayer, f : Double) -> SignalspecminnormLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormLayer::add(self : SignalspecminnormLayer, other : SignalspecminnormLayer) -> SignalspecminnormLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormLayer::copy(self : SignalspecminnormLayer) -> SignalspecminnormLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormLayer::fill(self : SignalspecminnormLayer, v : Double) -> SignalspecminnormLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormLayer::min(self : SignalspecminnormLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormLayer::max(self : SignalspecminnormLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormLayer::to_string(self : SignalspecminnormLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_buffer_make(size : Int) -> SignalspecminnormBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormBuffer::len(self : SignalspecminnormBuffer) -> Int { self.size }

pub fn SignalspecminnormBuffer::get(self : SignalspecminnormBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormBuffer::set(self : SignalspecminnormBuffer, i : Int, v : Double) -> SignalspecminnormBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormBuffer::sum(self : SignalspecminnormBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormBuffer::mean(self : SignalspecminnormBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormBuffer::scale(self : SignalspecminnormBuffer, f : Double) -> SignalspecminnormBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormBuffer::add(self : SignalspecminnormBuffer, other : SignalspecminnormBuffer) -> SignalspecminnormBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormBuffer::copy(self : SignalspecminnormBuffer) -> SignalspecminnormBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormBuffer::fill(self : SignalspecminnormBuffer, v : Double) -> SignalspecminnormBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormBuffer::min(self : SignalspecminnormBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormBuffer::max(self : SignalspecminnormBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormBuffer::to_string(self : SignalspecminnormBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_cursor_make(size : Int) -> SignalspecminnormCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormCursor::len(self : SignalspecminnormCursor) -> Int { self.size }

pub fn SignalspecminnormCursor::get(self : SignalspecminnormCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormCursor::set(self : SignalspecminnormCursor, i : Int, v : Double) -> SignalspecminnormCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCursor::sum(self : SignalspecminnormCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormCursor::mean(self : SignalspecminnormCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormCursor::scale(self : SignalspecminnormCursor, f : Double) -> SignalspecminnormCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCursor::add(self : SignalspecminnormCursor, other : SignalspecminnormCursor) -> SignalspecminnormCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormCursor::copy(self : SignalspecminnormCursor) -> SignalspecminnormCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCursor::fill(self : SignalspecminnormCursor, v : Double) -> SignalspecminnormCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormCursor::min(self : SignalspecminnormCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormCursor::max(self : SignalspecminnormCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormCursor::to_string(self : SignalspecminnormCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_view_make(size : Int) -> SignalspecminnormView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormView::len(self : SignalspecminnormView) -> Int { self.size }

pub fn SignalspecminnormView::get(self : SignalspecminnormView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormView::set(self : SignalspecminnormView, i : Int, v : Double) -> SignalspecminnormView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormView::sum(self : SignalspecminnormView) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormView::mean(self : SignalspecminnormView) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormView::scale(self : SignalspecminnormView, f : Double) -> SignalspecminnormView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormView::add(self : SignalspecminnormView, other : SignalspecminnormView) -> SignalspecminnormView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormView::copy(self : SignalspecminnormView) -> SignalspecminnormView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormView::fill(self : SignalspecminnormView, v : Double) -> SignalspecminnormView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormView::min(self : SignalspecminnormView) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormView::max(self : SignalspecminnormView) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormView::to_string(self : SignalspecminnormView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_range_make(size : Int) -> SignalspecminnormRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormRange::len(self : SignalspecminnormRange) -> Int { self.size }

pub fn SignalspecminnormRange::get(self : SignalspecminnormRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormRange::set(self : SignalspecminnormRange, i : Int, v : Double) -> SignalspecminnormRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormRange::sum(self : SignalspecminnormRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormRange::mean(self : SignalspecminnormRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormRange::scale(self : SignalspecminnormRange, f : Double) -> SignalspecminnormRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormRange::add(self : SignalspecminnormRange, other : SignalspecminnormRange) -> SignalspecminnormRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormRange::copy(self : SignalspecminnormRange) -> SignalspecminnormRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormRange::fill(self : SignalspecminnormRange, v : Double) -> SignalspecminnormRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormRange::min(self : SignalspecminnormRange) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormRange::max(self : SignalspecminnormRange) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormRange::to_string(self : SignalspecminnormRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_slice_make(size : Int) -> SignalspecminnormSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecminnormSlice::len(self : SignalspecminnormSlice) -> Int { self.size }

pub fn SignalspecminnormSlice::get(self : SignalspecminnormSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecminnormSlice::set(self : SignalspecminnormSlice, i : Int, v : Double) -> SignalspecminnormSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecminnormSlice::sum(self : SignalspecminnormSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecminnormSlice::mean(self : SignalspecminnormSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecminnormSlice::scale(self : SignalspecminnormSlice, f : Double) -> SignalspecminnormSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormSlice::add(self : SignalspecminnormSlice, other : SignalspecminnormSlice) -> SignalspecminnormSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecminnormSlice::copy(self : SignalspecminnormSlice) -> SignalspecminnormSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormSlice::fill(self : SignalspecminnormSlice, v : Double) -> SignalspecminnormSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecminnormSlice::min(self : SignalspecminnormSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecminnormSlice::max(self : SignalspecminnormSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecminnormSlice::to_string(self : SignalspecminnormSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

