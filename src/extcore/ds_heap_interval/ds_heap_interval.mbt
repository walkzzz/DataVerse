///===
/// extcore/ds_heap_interval

pub(all) struct DsheapintervalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_interval_make_point(x : Double, y : Double) -> DsheapintervalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_interval_make_point3(x : Double, y : Double, z : Double) -> DsheapintervalPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapintervalPoint::x(self : DsheapintervalPoint) -> Double { self.x }

pub fn DsheapintervalPoint::y(self : DsheapintervalPoint) -> Double { self.y }

pub fn DsheapintervalPoint::z(self : DsheapintervalPoint) -> Double { self.z }

pub fn DsheapintervalPoint::label(self : DsheapintervalPoint) -> Int { self.label }

pub fn DsheapintervalPoint::dist(self : DsheapintervalPoint, other : DsheapintervalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapintervalPoint::add(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapintervalPoint::sub(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapintervalPoint::scale(self : DsheapintervalPoint, s : Double) -> DsheapintervalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapintervalPoint::dot(self : DsheapintervalPoint, other : DsheapintervalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapintervalPoint::cross(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapintervalPoint::norm(self : DsheapintervalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapintervalPoint::normalize(self : DsheapintervalPoint) -> DsheapintervalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapintervalPoint::negate(self : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapintervalPoint::mid(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapintervalPoint::lerp(self : DsheapintervalPoint, other : DsheapintervalPoint, t : Double) -> DsheapintervalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapintervalPoint::to_string(self : DsheapintervalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapintervalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_interval_make_series(vals : Array[Double], name : String) -> DsheapintervalSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapintervalSeries::len(self : DsheapintervalSeries) -> Int { self.vals.length() }

pub fn DsheapintervalSeries::sum(self : DsheapintervalSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapintervalSeries::mean(self : DsheapintervalSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapintervalSeries::min(self : DsheapintervalSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapintervalSeries::max(self : DsheapintervalSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapintervalSeries::range(self : DsheapintervalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapintervalSeries::variance(self : DsheapintervalSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapintervalSeries::std(self : DsheapintervalSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapintervalSeries::median(self : DsheapintervalSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapintervalSeries::scale(self : DsheapintervalSeries, f : Double) -> DsheapintervalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapintervalSeries::add(self : DsheapintervalSeries, other : DsheapintervalSeries) -> DsheapintervalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapintervalSeries::sub(self : DsheapintervalSeries, other : DsheapintervalSeries) -> DsheapintervalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapintervalSeries::normalize(self : DsheapintervalSeries) -> DsheapintervalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapintervalSeries::cumsum(self : DsheapintervalSeries) -> DsheapintervalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapintervalSeries::to_string(self : DsheapintervalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapintervalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_interval_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapintervalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_interval_matrix_identity(n : Int) -> DsheapintervalMatrix {
  let m = ds_heap_interval_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapintervalMatrix::get(self : DsheapintervalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapintervalMatrix::transpose(self : DsheapintervalMatrix) -> DsheapintervalMatrix {
  let result = ds_heap_interval_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapintervalMatrix::add(self : DsheapintervalMatrix, other : DsheapintervalMatrix) -> DsheapintervalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_interval_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapintervalMatrix::scale(self : DsheapintervalMatrix, s : Double) -> DsheapintervalMatrix {
  let result = ds_heap_interval_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapintervalMatrix::multiply(self : DsheapintervalMatrix, other : DsheapintervalMatrix) -> DsheapintervalMatrix {
  if self.cols != other.rows { return ds_heap_interval_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_interval_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapintervalMatrix::trace(self : DsheapintervalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapintervalMatrix::det(self : DsheapintervalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapintervalMatrix::norm(self : DsheapintervalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapintervalMatrix::to_string(self : DsheapintervalMatrix) -> String {
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

pub(all) struct DsheapintervalVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_interval_make_vector(comps : Array[Double]) -> DsheapintervalVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_interval_vector_zero(dim : Int) -> DsheapintervalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapintervalVector::add(self : DsheapintervalVector, other : DsheapintervalVector) -> DsheapintervalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapintervalVector::sub(self : DsheapintervalVector, other : DsheapintervalVector) -> DsheapintervalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapintervalVector::scale(self : DsheapintervalVector, s : Double) -> DsheapintervalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapintervalVector::dot(self : DsheapintervalVector, other : DsheapintervalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapintervalVector::norm(self : DsheapintervalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapintervalVector::normalize(self : DsheapintervalVector) -> DsheapintervalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapintervalVector::dist(self : DsheapintervalVector, other : DsheapintervalVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapintervalVector::to_string(self : DsheapintervalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapintervalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_frame_make(size : Int) -> DsheapintervalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalFrame::len(self : DsheapintervalFrame) -> Int { self.size }

pub fn DsheapintervalFrame::get(self : DsheapintervalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalFrame::set(self : DsheapintervalFrame, i : Int, v : Double) -> DsheapintervalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalFrame::sum(self : DsheapintervalFrame) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalFrame::mean(self : DsheapintervalFrame) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalFrame::scale(self : DsheapintervalFrame, f : Double) -> DsheapintervalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalFrame::add(self : DsheapintervalFrame, other : DsheapintervalFrame) -> DsheapintervalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalFrame::copy(self : DsheapintervalFrame) -> DsheapintervalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalFrame::fill(self : DsheapintervalFrame, v : Double) -> DsheapintervalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalFrame::min(self : DsheapintervalFrame) -> Double { @_common.min(self.data) }

pub fn DsheapintervalFrame::max(self : DsheapintervalFrame) -> Double { @_common.max(self.data) }

pub fn DsheapintervalFrame::to_string(self : DsheapintervalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_table_make(size : Int) -> DsheapintervalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalTable::len(self : DsheapintervalTable) -> Int { self.size }

pub fn DsheapintervalTable::get(self : DsheapintervalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalTable::set(self : DsheapintervalTable, i : Int, v : Double) -> DsheapintervalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalTable::sum(self : DsheapintervalTable) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalTable::mean(self : DsheapintervalTable) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalTable::scale(self : DsheapintervalTable, f : Double) -> DsheapintervalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalTable::add(self : DsheapintervalTable, other : DsheapintervalTable) -> DsheapintervalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalTable::copy(self : DsheapintervalTable) -> DsheapintervalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalTable::fill(self : DsheapintervalTable, v : Double) -> DsheapintervalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalTable::min(self : DsheapintervalTable) -> Double { @_common.min(self.data) }

pub fn DsheapintervalTable::max(self : DsheapintervalTable) -> Double { @_common.max(self.data) }

pub fn DsheapintervalTable::to_string(self : DsheapintervalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_graphn_make(size : Int) -> DsheapintervalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalGraphN::len(self : DsheapintervalGraphN) -> Int { self.size }

pub fn DsheapintervalGraphN::get(self : DsheapintervalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalGraphN::set(self : DsheapintervalGraphN, i : Int, v : Double) -> DsheapintervalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalGraphN::sum(self : DsheapintervalGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalGraphN::mean(self : DsheapintervalGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalGraphN::scale(self : DsheapintervalGraphN, f : Double) -> DsheapintervalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalGraphN::add(self : DsheapintervalGraphN, other : DsheapintervalGraphN) -> DsheapintervalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalGraphN::copy(self : DsheapintervalGraphN) -> DsheapintervalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalGraphN::fill(self : DsheapintervalGraphN, v : Double) -> DsheapintervalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalGraphN::min(self : DsheapintervalGraphN) -> Double { @_common.min(self.data) }

pub fn DsheapintervalGraphN::max(self : DsheapintervalGraphN) -> Double { @_common.max(self.data) }

pub fn DsheapintervalGraphN::to_string(self : DsheapintervalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_node_make(size : Int) -> DsheapintervalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalNode::len(self : DsheapintervalNode) -> Int { self.size }

pub fn DsheapintervalNode::get(self : DsheapintervalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalNode::set(self : DsheapintervalNode, i : Int, v : Double) -> DsheapintervalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalNode::sum(self : DsheapintervalNode) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalNode::mean(self : DsheapintervalNode) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalNode::scale(self : DsheapintervalNode, f : Double) -> DsheapintervalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalNode::add(self : DsheapintervalNode, other : DsheapintervalNode) -> DsheapintervalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalNode::copy(self : DsheapintervalNode) -> DsheapintervalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalNode::fill(self : DsheapintervalNode, v : Double) -> DsheapintervalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalNode::min(self : DsheapintervalNode) -> Double { @_common.min(self.data) }

pub fn DsheapintervalNode::max(self : DsheapintervalNode) -> Double { @_common.max(self.data) }

pub fn DsheapintervalNode::to_string(self : DsheapintervalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_edge_make(size : Int) -> DsheapintervalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalEdge::len(self : DsheapintervalEdge) -> Int { self.size }

pub fn DsheapintervalEdge::get(self : DsheapintervalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalEdge::set(self : DsheapintervalEdge, i : Int, v : Double) -> DsheapintervalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalEdge::sum(self : DsheapintervalEdge) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalEdge::mean(self : DsheapintervalEdge) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalEdge::scale(self : DsheapintervalEdge, f : Double) -> DsheapintervalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalEdge::add(self : DsheapintervalEdge, other : DsheapintervalEdge) -> DsheapintervalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalEdge::copy(self : DsheapintervalEdge) -> DsheapintervalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalEdge::fill(self : DsheapintervalEdge, v : Double) -> DsheapintervalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalEdge::min(self : DsheapintervalEdge) -> Double { @_common.min(self.data) }

pub fn DsheapintervalEdge::max(self : DsheapintervalEdge) -> Double { @_common.max(self.data) }

pub fn DsheapintervalEdge::to_string(self : DsheapintervalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_path_make(size : Int) -> DsheapintervalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalPath::len(self : DsheapintervalPath) -> Int { self.size }

pub fn DsheapintervalPath::get(self : DsheapintervalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalPath::set(self : DsheapintervalPath, i : Int, v : Double) -> DsheapintervalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalPath::sum(self : DsheapintervalPath) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalPath::mean(self : DsheapintervalPath) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalPath::scale(self : DsheapintervalPath, f : Double) -> DsheapintervalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalPath::add(self : DsheapintervalPath, other : DsheapintervalPath) -> DsheapintervalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalPath::copy(self : DsheapintervalPath) -> DsheapintervalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalPath::fill(self : DsheapintervalPath, v : Double) -> DsheapintervalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalPath::min(self : DsheapintervalPath) -> Double { @_common.min(self.data) }

pub fn DsheapintervalPath::max(self : DsheapintervalPath) -> Double { @_common.max(self.data) }

pub fn DsheapintervalPath::to_string(self : DsheapintervalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_cluster_make(size : Int) -> DsheapintervalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalCluster::len(self : DsheapintervalCluster) -> Int { self.size }

pub fn DsheapintervalCluster::get(self : DsheapintervalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalCluster::set(self : DsheapintervalCluster, i : Int, v : Double) -> DsheapintervalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalCluster::sum(self : DsheapintervalCluster) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalCluster::mean(self : DsheapintervalCluster) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalCluster::scale(self : DsheapintervalCluster, f : Double) -> DsheapintervalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalCluster::add(self : DsheapintervalCluster, other : DsheapintervalCluster) -> DsheapintervalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalCluster::copy(self : DsheapintervalCluster) -> DsheapintervalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalCluster::fill(self : DsheapintervalCluster, v : Double) -> DsheapintervalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalCluster::min(self : DsheapintervalCluster) -> Double { @_common.min(self.data) }

pub fn DsheapintervalCluster::max(self : DsheapintervalCluster) -> Double { @_common.max(self.data) }

pub fn DsheapintervalCluster::to_string(self : DsheapintervalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_model_make(size : Int) -> DsheapintervalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalModel::len(self : DsheapintervalModel) -> Int { self.size }

pub fn DsheapintervalModel::get(self : DsheapintervalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalModel::set(self : DsheapintervalModel, i : Int, v : Double) -> DsheapintervalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalModel::sum(self : DsheapintervalModel) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalModel::mean(self : DsheapintervalModel) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalModel::scale(self : DsheapintervalModel, f : Double) -> DsheapintervalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalModel::add(self : DsheapintervalModel, other : DsheapintervalModel) -> DsheapintervalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalModel::copy(self : DsheapintervalModel) -> DsheapintervalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalModel::fill(self : DsheapintervalModel, v : Double) -> DsheapintervalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalModel::min(self : DsheapintervalModel) -> Double { @_common.min(self.data) }

pub fn DsheapintervalModel::max(self : DsheapintervalModel) -> Double { @_common.max(self.data) }

pub fn DsheapintervalModel::to_string(self : DsheapintervalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_layer_make(size : Int) -> DsheapintervalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalLayer::len(self : DsheapintervalLayer) -> Int { self.size }

pub fn DsheapintervalLayer::get(self : DsheapintervalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalLayer::set(self : DsheapintervalLayer, i : Int, v : Double) -> DsheapintervalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalLayer::sum(self : DsheapintervalLayer) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalLayer::mean(self : DsheapintervalLayer) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalLayer::scale(self : DsheapintervalLayer, f : Double) -> DsheapintervalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalLayer::add(self : DsheapintervalLayer, other : DsheapintervalLayer) -> DsheapintervalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalLayer::copy(self : DsheapintervalLayer) -> DsheapintervalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalLayer::fill(self : DsheapintervalLayer, v : Double) -> DsheapintervalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalLayer::min(self : DsheapintervalLayer) -> Double { @_common.min(self.data) }

pub fn DsheapintervalLayer::max(self : DsheapintervalLayer) -> Double { @_common.max(self.data) }

pub fn DsheapintervalLayer::to_string(self : DsheapintervalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_buffer_make(size : Int) -> DsheapintervalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalBuffer::len(self : DsheapintervalBuffer) -> Int { self.size }

pub fn DsheapintervalBuffer::get(self : DsheapintervalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalBuffer::set(self : DsheapintervalBuffer, i : Int, v : Double) -> DsheapintervalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalBuffer::sum(self : DsheapintervalBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalBuffer::mean(self : DsheapintervalBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalBuffer::scale(self : DsheapintervalBuffer, f : Double) -> DsheapintervalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalBuffer::add(self : DsheapintervalBuffer, other : DsheapintervalBuffer) -> DsheapintervalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalBuffer::copy(self : DsheapintervalBuffer) -> DsheapintervalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalBuffer::fill(self : DsheapintervalBuffer, v : Double) -> DsheapintervalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalBuffer::min(self : DsheapintervalBuffer) -> Double { @_common.min(self.data) }

pub fn DsheapintervalBuffer::max(self : DsheapintervalBuffer) -> Double { @_common.max(self.data) }

pub fn DsheapintervalBuffer::to_string(self : DsheapintervalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_cursor_make(size : Int) -> DsheapintervalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalCursor::len(self : DsheapintervalCursor) -> Int { self.size }

pub fn DsheapintervalCursor::get(self : DsheapintervalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalCursor::set(self : DsheapintervalCursor, i : Int, v : Double) -> DsheapintervalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalCursor::sum(self : DsheapintervalCursor) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalCursor::mean(self : DsheapintervalCursor) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalCursor::scale(self : DsheapintervalCursor, f : Double) -> DsheapintervalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalCursor::add(self : DsheapintervalCursor, other : DsheapintervalCursor) -> DsheapintervalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalCursor::copy(self : DsheapintervalCursor) -> DsheapintervalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalCursor::fill(self : DsheapintervalCursor, v : Double) -> DsheapintervalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalCursor::min(self : DsheapintervalCursor) -> Double { @_common.min(self.data) }

pub fn DsheapintervalCursor::max(self : DsheapintervalCursor) -> Double { @_common.max(self.data) }

pub fn DsheapintervalCursor::to_string(self : DsheapintervalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_view_make(size : Int) -> DsheapintervalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalView::len(self : DsheapintervalView) -> Int { self.size }

pub fn DsheapintervalView::get(self : DsheapintervalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalView::set(self : DsheapintervalView, i : Int, v : Double) -> DsheapintervalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalView::sum(self : DsheapintervalView) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalView::mean(self : DsheapintervalView) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalView::scale(self : DsheapintervalView, f : Double) -> DsheapintervalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalView::add(self : DsheapintervalView, other : DsheapintervalView) -> DsheapintervalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalView::copy(self : DsheapintervalView) -> DsheapintervalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalView::fill(self : DsheapintervalView, v : Double) -> DsheapintervalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalView::min(self : DsheapintervalView) -> Double { @_common.min(self.data) }

pub fn DsheapintervalView::max(self : DsheapintervalView) -> Double { @_common.max(self.data) }

pub fn DsheapintervalView::to_string(self : DsheapintervalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_range_make(size : Int) -> DsheapintervalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalRange::len(self : DsheapintervalRange) -> Int { self.size }

pub fn DsheapintervalRange::get(self : DsheapintervalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalRange::set(self : DsheapintervalRange, i : Int, v : Double) -> DsheapintervalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalRange::sum(self : DsheapintervalRange) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalRange::mean(self : DsheapintervalRange) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalRange::scale(self : DsheapintervalRange, f : Double) -> DsheapintervalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalRange::add(self : DsheapintervalRange, other : DsheapintervalRange) -> DsheapintervalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalRange::copy(self : DsheapintervalRange) -> DsheapintervalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalRange::fill(self : DsheapintervalRange, v : Double) -> DsheapintervalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalRange::min(self : DsheapintervalRange) -> Double { @_common.min(self.data) }

pub fn DsheapintervalRange::max(self : DsheapintervalRange) -> Double { @_common.max(self.data) }

pub fn DsheapintervalRange::to_string(self : DsheapintervalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapintervalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_slice_make(size : Int) -> DsheapintervalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapintervalSlice::len(self : DsheapintervalSlice) -> Int { self.size }

pub fn DsheapintervalSlice::get(self : DsheapintervalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapintervalSlice::set(self : DsheapintervalSlice, i : Int, v : Double) -> DsheapintervalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapintervalSlice::sum(self : DsheapintervalSlice) -> Double { @_common.sum(self.data) }

pub fn DsheapintervalSlice::mean(self : DsheapintervalSlice) -> Double { @_common.mean(self.data) }

pub fn DsheapintervalSlice::scale(self : DsheapintervalSlice, f : Double) -> DsheapintervalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapintervalSlice::add(self : DsheapintervalSlice, other : DsheapintervalSlice) -> DsheapintervalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapintervalSlice::copy(self : DsheapintervalSlice) -> DsheapintervalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapintervalSlice::fill(self : DsheapintervalSlice, v : Double) -> DsheapintervalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapintervalSlice::min(self : DsheapintervalSlice) -> Double { @_common.min(self.data) }

pub fn DsheapintervalSlice::max(self : DsheapintervalSlice) -> Double { @_common.max(self.data) }

pub fn DsheapintervalSlice::to_string(self : DsheapintervalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

